variable "aws_vpc_enable_resource" {
  type        = bool
  description = "aws vpc enable resource"
}

variable "kms_key" {
  type        = string
  description = "kms keys available"
}

variable "state" {
  type        = string
  description = "state of aws availability zones"
}

variable "security_group_id" {
  type        = list(string)
  description = "value of security group id"
}

variable "subnet_ids" {
  type        = list(string)
  description = "value of subnet ids"
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "kafka_versions" {
  type        = list(string)
  description = "Version of Kafka aws msk configuration"
}

variable "kafka_version" {
  type        = string
  description = "Version of Kafka brokers"
}

variable "kafka_broker_number" {
  type        = number
  description = "Kafka brokers per zone"
}

variable "kafka_instance_type" {
  type        = string
  description = "Kafka broker instance type"
}

variable "kafka_ebs_volume_size" {
  type        = string
  description = "Kafka EBS volume size in GB"
}

variable "kafka_encryption_in_transit" {
  type        = string
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT."
}

variable "kafka_monitoring_level" {
  type        = string
  description = "property to one of three monitoring levels: DEFAULT, PER_BROKER, or PER_TOPIC_PER_BROKER"
}

variable "kafka_custom_config_auto_create_topics" {
  type        = bool
  description = "Enables topic autocreation on the server"
}

variable "kafka_custom_config_delete_topics" {
  type        = bool
  description = "Enables the delete topic operation. If this config is turned off, you can't delete a topic through the admin tool"
}

variable "kafka_custom_config_log_retention" {
  type        = number
  description = "Number of hours to keep a log file before deleting it, tertiary to the log.retention.ms property."
}

variable "kafka_custom_config_default_replication_factor" {
  type        = number
  description = "kafka custom config default replication factor value"
}

variable "kafka_custom_config_min_insync_replicas" {
  type        = number
  description = "kafka custom config min insync replicas value"
}

variable "kafka_custom_config_num_io_threads" {
  type        = number
  description = "kafka custom config num io threads value"
}

variable "kafka_custom_config_num_network_threads" {
  type        = number
  description = "kafka custom config num network threads value"
}

variable "kafka_custom_config_num_partitions" {
  type        = number
  description = "kafka custom config num partitions value"
}

variable "kafka_custom_config_num_replica_fetchers" {
  type        = number
  description = "kafka custom config num replica fetchers value"
}

variable "kafka_custom_config_socket_request_max_bytes" {
  type        = number
  description = "kafka custom config socket request max bytes value"
}

variable "kafka_custom_config_unclean_leader_election_enable" {
  type        = bool
  description = "kafka custom config unclean leader election enable, true or flase"
}

variable "kafka_custom_config_offsets_topic_replication_factor" {
  type        = number
  description = "kafka custom config offsets topic replication factor"
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources"
  type        = map(string)
}







