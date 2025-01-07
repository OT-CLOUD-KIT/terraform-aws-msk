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
