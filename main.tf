# Security group creation for MSK
resource "aws_security_group" "msk_sec_grp" {
  count       = var.create_sec_grp ? 1 : 0
  vpc_id      = var.vpc_id
  description = "Security group for managing MSK connectivity rules"
  name        = format("%s-sec-grp", var.name)
  tags = merge(
    { "Name" = format("%s-sec-grp", var.name) },
    var.tags
  )

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = "tcp"
      security_groups = ingress.value.security_group_ids
      cidr_blocks     = ingress.value.cidr_blocks
    }
  }
}

# MSK cluster configuration creation code
resource "aws_msk_configuration" "msk_config" {
  name              = format("%s-config", var.name)
  server_properties = join("\n", [for prop_key in keys(var.server_properties) : format("%s = %s", prop_key, var.server_properties[prop_key])])
  description       = "Configuration for MSK"
  kafka_versions    = [var.kafka_version]

  lifecycle {
    create_before_destroy = true
  }
}

# KMS key creation for data encryption
resource "aws_kms_key" "kms" {
  count                    = var.create_kms_key ? 1 : 0
  description              = "KMS key to encrypt and decrypt MSK data"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled               = true
}

# MSK cluster creation and management code
resource "aws_msk_cluster" "msk" {
  cluster_name           = format("%s-cluster", var.name)
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.brokers_count
  enhanced_monitoring    = var.enhanced_monitoring

  broker_node_group_info {
    client_subnets  = var.subnet_ids
    instance_type   = var.broker_instance_type
    security_groups = var.create_sec_grp ? concat(var.broker_sec_grp_ids, aws_security_group.msk_sec_grp[*].id) : var.broker_sec_grp_ids

    storage_info {
      ebs_storage_info {
        volume_size = var.broker_volume_size
      }
    }

    connectivity_info {
      public_access {
        type = "DISABLED"
      }
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.msk_config.arn
    revision = aws_msk_configuration.msk_config.latest_revision
  }

  encryption_info {
    encryption_in_transit {
      client_broker = var.client_broker_protocol
      in_cluster    = var.encryption_in_cluster_enabled
    }

    encryption_at_rest_kms_key_arn = var.create_kms_key ? aws_kms_key.kms[0].arn : var.encryption_at_rest_kms_key_arn
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.enable_open_monitoring
      }
      node_exporter {
        enabled_in_broker = var.enable_open_monitoring
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = var.cloudwatch_logs_enabled
        log_group = var.cloudwatch_logs_log_group
      }

      firehose {
        enabled         = var.firehose_logs_enabled
        delivery_stream = var.firehose_delivery_stream
      }

      s3 {
        enabled = var.s3_logs_enabled
        bucket  = var.s3_logs_bucket
        prefix  = var.s3_logs_prefix
      }
    }
  }

  client_authentication {
    sasl {
      scram = var.client_sasl_scram_enabled
    }
  }
  tags = merge(
    { "Name" = format("%s-cluster", var.name) },
    var.tags
  )
}

## Secret Manager integration for authentication
resource "aws_msk_scram_secret_association" "scram_association" {
  count           = var.client_sasl_scram_enabled ? 1 : 0
  cluster_arn     = aws_msk_cluster.msk.arn
  secret_arn_list = var.aws_secret_manager_arn
}

## Autoscaling of MSK storage service
resource "aws_appautoscaling_target" "msk_target" {
  count              = var.autoscaling_enabled ? 1 : 0
  max_capacity       = var.max_volume_size
  min_capacity       = 1
  resource_id        = aws_msk_cluster.msk.arn
  scalable_dimension = "kafka:broker-storage:VolumeSize"
  service_namespace  = "kafka"
}

resource "aws_appautoscaling_policy" "msk_policy" {
  count              = var.autoscaling_enabled ? 1 : 0
  name               = format("%s-broker-scaling", aws_msk_cluster.msk.cluster_name)
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_msk_cluster.msk.arn
  scalable_dimension = one(aws_appautoscaling_target.msk_target[*].scalable_dimension)
  service_namespace  = one(aws_appautoscaling_target.msk_target[*].service_namespace)

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "KafkaBrokerStorageUtilization"
    }

    target_value = var.scaling_target_threshold
  }
}
