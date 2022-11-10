variable "state" {
  type        = string
  description = "state of aws availability zones"
  default     = "available"
}

variable "kafka_tag_key" {
  type        = string
  description = "tag key for kafka resource"
  default     = "vpc"
}

variable "kafka_tag_value" {
  type        = string
  description = "kafka tag values for getting already created aws resources"
  default     = "devops"
}

variable "kafka_custom_config" {
  type        = string
  description = "Kafka custom config json file"
  default     = ""
}

variable "name_prefix" {
  type        = string
  description = "A prefix used for naming resources."
  default     = "example"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnets ID"
}

variable "kafka_SG_id" {
  type        = list(string)
  description = "security group ID"
}

variable "kafka_version" {
  type        = string
  description = "Version of Kafka brokers"
  default     = "3.2.0"
}

variable "kafka_broker_number" {
  type        = number
  description = "Kafka brokers per zone"
  default     = 3
}

variable "kafka_instance_type" {
  type        = string
  description = "Kafka broker instance type"
  default     = "kafka.m5.large"
}

variable "kafka_ebs_volume_size" {
  type        = string
  description = "Kafka EBS volume size in GB"
  default     = "100"
}

## STORAGE ENCRYPTION

variable "kafka_encryption_in_transit" {
  type        = string
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT."
  default     = "TLS_PLAINTEXT"
}

variable "kms_key_arn" {
  type        = string
  default = " "
  description = "kms key for encryption"
}

## KMS KEY

variable "create_kafka_kms_key_id" {
  type        = bool
  default     = false
  description = "The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true."
}

variable "key_name" {
  description = "The name of the key alias"
  type        = string
}

variable "key_usage" {
  description = "Specifies the intended use of the key. Valid values: ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC."
  type = string
  default = "ENCRYPT_DECRYPT" 
}

variable "customer_master_key_spec" {
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports"
  type = string
  default = "SYMMETRIC_DEFAULT"
}

variable "deletion_window_in_days" {
  description = "The duration in days after which the key is deleted after destruction of the resource"
  type        = string
  default     = 30
}

variable "multi_region" {
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
  type = bool
  default = false  
}

variable "is_enabled" {
  description = "Status of key enable or disbale"
  type        = bool
  default     = true
}

variable "enable_key_rotation" {
  description = "enable_key_rotation"
  type        = bool
  default     = false
}

variable "kms_key_tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "kms_policy" {
  description = "The policy of the key usage"
  type        = any
  default     = ""
}


## KAFKA MONITORING

variable "kafka_monitoring_level" {
  type        = string
  description = "property to one of three monitoring levels: DEFAULT, PER_BROKER, or PER_TOPIC_PER_BROKER"
  default     = "PER_TOPIC_PER_BROKER"
}

variable "enable_jmx_exporter" {
  type        = bool
  default     = false
  description = "enable monitoring form jmx exporter on broker node"
}

variable "enable_node_exporter" {
  type        = bool
  default     = false
  description = "enable monitoring form node exporter on broker node"
}

## kafka logging

variable "enable_logging_info_cloudwatch" {
  type        = bool
  default     = false
  description = "enable logging to cloudwatch"
}

variable "cloudwatch_log_group" {
  type        = string
  default     = " "
  description = "name of log group for cloudwatch"
}

variable "enable_logging_info_firehouse" {
  type        = bool
  default     = false
  description = "enable logging to firehouse"
}

variable "firehose_delivery_stream" {
  type        = string
  default     = " "
  description = "name of firehouse delivery stream"
}

variable "enable_logging_info_s3" {
  type        = bool
  default     = false
  description = "enable logging to s3"
}

variable "s3_bucket_id" {
  type        = string
  default     = " "
  description = "s3 bucket id"
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources"
  type        = map(string)
  default     = {}
}

## STORAGE AUTO SCALLING

variable "enable_storage_autoscaling" {
  type = bool
  default = false
  description = "to enable auto scaling for msk cluster set it to true"
}

variable "scaling_max_capacity" {
  type = string
  default = "200"
  description = "max capacity for storage"
}

variable "scaling_target_value" {
  type = string
  default = "50"
  description = "target value for scaling"
}