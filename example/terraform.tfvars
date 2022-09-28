aws_vpc_enable_resource                              = true
kms_key                                              = ""
state                                                = "available"
# security_group_id                                    = []
# subnet_ids                                           = []
name_prefix                                          = "example"
kafka_version                                        = "3.2.0"
kafka_versions                                       = ["3.2.0"]
kafka_broker_number                                  = 3
kafka_instance_type                                  = "kafka.m5.large"
kafka_ebs_volume_size                                = "100"
kafka_encryption_in_transit                          = "TLS_PLAINTEXT"
kafka_monitoring_level                               = "PER_TOPIC_PER_BROKER"
kafka_custom_config_auto_create_topics               = true
kafka_custom_config_delete_topics                    = false
kafka_custom_config_log_retention                    = null
kafka_custom_config_default_replication_factor       = 2
kafka_custom_config_min_insync_replicas              = 1
kafka_custom_config_num_io_threads                   = 8
kafka_custom_config_num_network_threads              = 5
kafka_custom_config_num_partitions                   = 2
kafka_custom_config_num_replica_fetchers             = 2
kafka_custom_config_socket_request_max_bytes         = 104857600
kafka_custom_config_unclean_leader_election_enable   = true
kafka_custom_config_offsets_topic_replication_factor = 1
tags = {
  name : "opstree"
  environment : "dev"
  team : "devops"
}

