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
}
