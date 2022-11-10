## KMS KEY
resource "aws_kms_key" "kms" {
  count       = var.create_kafka_kms_key_id == true ? 1 : 0
  description              = "Key to encrypt and decrypt kafka storage"
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  policy                   = var.kms_policy
  multi_region             = var.multi_region 
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation

  tags = merge(
    {
      "Name" = var.key_name
    },
    var.kms_key_tags,
  )
}
resource "aws_kms_alias" "key_alias" {
  count       = var.create_kafka_kms_key_id == true ? 1 : 0
  name          = "alias/${var.key_name}"
  target_key_id = aws_kms_key.kms[0].id
}

## CLOUDWATCH LOG GROUP
resource "aws_cloudwatch_log_group" "main" {
  name = "${var.name_prefix}-msk-broker-logs"
}

## CLUSTER CONFIGURATION 
resource "aws_msk_configuration" "mks-cluster-custom-configuration" {
  kafka_versions    = ["2.3.1"]
  name              = "${var.name_prefix}-mks-cluster-custom-configuration"
  server_properties = var.kafka_custom_config
}

## MSK CLUSTER
resource "aws_msk_cluster" "msk-cluster" {
  cluster_name           = "${var.name_prefix}-msk-cluster"
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.kafka_broker_number

  broker_node_group_info {
    instance_type   = var.kafka_instance_type
    ebs_volume_size = var.kafka_ebs_volume_size
    client_subnets  = var.subnet_ids
    security_groups = var.kafka_SG_id
  }

  encryption_info {
    encryption_in_transit {
      client_broker = var.kafka_encryption_in_transit
    }
    encryption_at_rest_kms_key_arn = var.create_kafka_kms_key_id == true ? aws_kms_key.kms[0].arn : var.kms_key_arn
  }

  configuration_info {
    arn      = aws_msk_configuration.mks-cluster-custom-configuration.arn
    revision = aws_msk_configuration.mks-cluster-custom-configuration.latest_revision
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.enable_jmx_exporter
      }
      node_exporter {
        enabled_in_broker = var.enable_node_exporter
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = var.enable_logging_info_cloudwatch == " " ? false : var.enable_logging_info_cloudwatch
        log_group = var.cloudwatch_log_group == " " ? aws_cloudwatch_log_group.main.name : var.cloudwatch_log_group
      }
      firehose {
        enabled         = var.enable_logging_info_firehouse == " " ? false : var.enable_logging_info_firehouse
        delivery_stream = var.enable_logging_info_firehouse == true ? var.firehose_delivery_stream : null
      }
      s3 {
        enabled = var.enable_logging_info_s3 == " " ? false : var.enable_logging_info_s3
        bucket  = var.enable_logging_info_s3 == true ? var.s3_bucket_id : null
        prefix  = var.enable_logging_info_s3 == true ? "logs/msk-" : null
      }
    }
  }

  enhanced_monitoring = var.kafka_monitoring_level
  tags                = var.tags
}


## CLUSTER STORAGE AUTO SCALING
resource "aws_appautoscaling_target" "kafka_storage" {
  count              = var.enable_storage_autoscaling == true ? 1 : 0
  max_capacity       = var.scaling_max_capacity
  min_capacity       = 1
  resource_id        = aws_msk_cluster.msk-cluster.arn
  scalable_dimension = "kafka:broker-storage:VolumeSize"
  service_namespace  = "kafka"
}

resource "aws_appautoscaling_policy" "kafka_broker_scaling_policy" {
  count              = var.enable_storage_autoscaling == true ? 1 : 0
  name               = "${var.name_prefix}-broker-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_msk_cluster.msk-cluster.arn
  scalable_dimension = aws_appautoscaling_target.kafka_storage[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.kafka_storage[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "KafkaBrokerStorageUtilization"
    }
    target_value = var.scaling_target_value
  }
}

