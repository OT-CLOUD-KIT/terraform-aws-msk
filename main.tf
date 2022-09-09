resource "aws_kms_key" "kms" {
  description = "${var.name_prefix}-kms_key"
}

resource "aws_msk_cluster" "msk-cluster" {
  cluster_name           = "${var.name_prefix}-msk-cluster"
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.kafka_broker_number

  broker_node_group_info {
    instance_type   = var.kafka_instance_type
    ebs_volume_size = var.kafka_ebs_volume_size
    client_subnets  = data.aws_subnet_ids.subnet_ids.ids
    security_groups = data.aws_security_groups.sg.ids
  }

  encryption_info {
    encryption_in_transit {
      client_broker = var.kafka_encryption_in_transit
    }
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
  }

  configuration_info {
    arn      = aws_msk_configuration.mks-cluster-custom-configuration.arn
    revision = aws_msk_configuration.mks-cluster-custom-configuration.latest_revision
  }

  enhanced_monitoring = var.kafka_monitoring_level
  tags                = var.tags
}

resource "aws_msk_configuration" "mks-cluster-custom-configuration" {
  kafka_versions    = ["2.3.1"]
  name              = "${var.name_prefix}-mks-cluster-custom-configuration"
  server_properties = var.kafka_custom_config
}