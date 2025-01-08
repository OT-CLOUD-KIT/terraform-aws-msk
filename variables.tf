variable "vpc_id" {
  description = "VPC ID in which all resources will be created."
  type        = string
}

variable "name" {
  description = "Name of the all resources which will be created."
  type        = string
  default     = "msk"
}

variable "tags" {
  description = "Map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "create_sec_grp" {
  description = "Whether to create MSK security group or not."
  type        = bool
  default     = false
}

variable "ingress_rules" {
  description = "List of ingress rules which needs to be applied to MSK cluster."
  type = map(object({
    port               = string
    security_group_ids = optional(list(string))
    cidr_blocks        = optional(list(string))
  }))
}

variable "kafka_version" {
  description = "Kafka version which needs to be provisioned."
  type        = string
  default     = "3.5.1"
}

variable "server_properties" {
  description = "All kafka properties which is available in server.properties"
  type        = map(string)
  default     = {}
}

variable "brokers_count" {
  description = "The desired total number of broker nodes in the kafka cluster."
  type        = number
  default     = 2
}

variable "enhanced_monitoring" {
  description = "Specify the desired enhanced MSK CloudWatch monitoring level."
  type        = string
  default     = "DEFAULT"
}

variable "broker_sec_grp_ids" {
  description = "If security group is externally managed, the IDs can be passed via this variable."
  type        = list(string)
  default     = []
}

variable "broker_instance_type" {
  description = "Specify the instance type to use for the kafka brokers."
  type        = string
  default     = "kafka.m5.large"
}

variable "subnet_ids" {
  description = "A list of subnets to connect to in client VPC."
  type        = list(string)
  default     = []
}

variable "broker_volume_size" {
  description = "The size in GiB of the EBS volume for the data drive on each broker node."
  type        = number
  default     = 100
}

variable "client_broker_protocol" {
  description = "Encryption setting for data in transit between clients and brokers."
  type        = string
  default     = "TLS_PLAINTEXT"
}

variable "encryption_in_cluster_enabled" {
  description = "Whether data communication among broker nodes is encrypted"
  type        = bool
  default     = true
}

variable "create_kms_key" {
  description = "Whether to create KMS key for encryption"
  type        = bool
  default     = false
}

variable "encryption_at_rest_kms_key_arn" {
  description = "You may specify a KMS key short ID or ARN"
  type        = string
  default     = ""
}

variable "enable_open_monitoring" {
  description = "Set `true` to enable the open monitoring with node and jmx exporter"
  type        = bool
  default     = true
}

variable "cloudwatch_logs_enabled" {
  description = "Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs"
  type        = bool
  default     = false
}

variable "cloudwatch_logs_log_group" {
  description = "Name of the Cloudwatch Log Group to deliver logs to"
  type        = string
  default     = ""
}

variable "firehose_logs_enabled" {
  description = "Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose"
  type        = bool
  default     = false
}

variable "firehose_delivery_stream" {
  description = "Name of the Kinesis Data Firehose delivery stream to deliver logs to"
  type        = string
  default     = ""
}

variable "s3_logs_enabled" {
  description = " Indicates whether you want to enable or disable streaming broker logs to S3"
  type        = bool
  default     = false
}

variable "s3_logs_bucket" {
  description = "Name of the S3 bucket to deliver logs to"
  type        = string
  default     = ""
}

variable "s3_logs_prefix" {
  description = "Prefix to append to the S3 folder name logs are delivered to"
  type        = string
  default     = ""
}
