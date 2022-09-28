data "template_file" "msk-custom-configuration" {
  template = file("msk-custom-configuration.json.tpl")
  vars = {
    auto_create_topics_enable        = var.kafka_custom_config_auto_create_topics
    delete_topic_enable              = var.kafka_custom_config_delete_topics
    default_replication_factor       = var.kafka_custom_config_default_replication_factor
    min_insync_replicas              = var.kafka_custom_config_min_insync_replicas
    num_io_threads                   = var.kafka_custom_config_num_io_threads
    num_network_threads              = var.kafka_custom_config_num_network_threads
    num_partitions                   = var.kafka_custom_config_num_partitions
    num_replica_fetchers             = var.kafka_custom_config_num_replica_fetchers
    socket_request_max_bytes         = var.kafka_custom_config_socket_request_max_bytes
    unclean_leader_election_enable   = var.kafka_custom_config_unclean_leader_election_enable
    offsets_topic_replication_factor = var.kafka_custom_config_offsets_topic_replication_factor
  }
}

module "kafka" {
  source                      = "git::https://github.com/OT-CLOUD-KIT/terraform-aws-msk.git"
  count                       = var.aws_vpc_enable_resource == true ? 1 : 0
  kms_key                     = var.kms_key
  state                       = var.state
  security_group_id           = var.security_group_id 
  subnet_ids                  = var.subnet_ids        
  name_prefix                 = var.name_prefix
  kafka_version               = var.kafka_version
  kafka_versions              = var.kafka_versions
  kafka_broker_number         = var.kafka_broker_number
  kafka_instance_type         = var.kafka_instance_type
  kafka_ebs_volume_size       = var.kafka_ebs_volume_size
  kafka_encryption_in_transit = var.kafka_encryption_in_transit
  kafka_monitoring_level      = var.kafka_monitoring_level
  kafka_custom_config         = data.template_file.msk-custom-configuration.rendered
  tags                        = var.tags
}

  