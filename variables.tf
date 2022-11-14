variable "kms_key" {
  type        = string
  description = "kms keys available"
  default     = ""
}

variable "state" {
  type        = string
  description = "state of aws availability zones"
  default     = "available"
}

variable "security_group_id" {
  type        = list(string)
  description = "value of security group id"
}

variable "subnet_ids" {
  type        = list(string)
  description = "value of subnet ids"
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

variable "kafka_versions" {
  type        = list(string)
  description = "Version of Kafka aws msk configuration"
  default     = ["3.2.0"]
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

variable "kafka_encryption_in_transit" {
  type        = string
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT."
  default     = "TLS_PLAINTEXT"
  validation {
    condition     = contains(["TLS", "TLS_PLAINTEXT", "PLAINTEXT"], var.kafka_encryption_in_transit)
    error_message = "Valid values are \"TLS\",\"TLS_PLAINTEXT\",\"PLAINTEXT\"."
  }
}

variable "kafka_monitoring_level" {
  type        = string
  description = "property to one of three monitoring levels: DEFAULT, PER_BROKER, or PER_TOPIC_PER_BROKER"
  default     = "PER_TOPIC_PER_BROKER"
  validation {
    condition     = contains(["DEFAULT", "PER_BROKER", "PER_TOPIC_PER_BROKER"], var.kafka_monitoring_level)
    error_message = "Valid values are \"DEFAULT\",\"PER_BROKER\",\"PER_TOPIC_PER_BROKER\"."
  }
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources"
  type        = map(string)
  default     = {}
}