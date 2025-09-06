# General
variable "name" {
  description = "Name prefix for all resources"
  type        = string

}


# VPC & Networking
variable "vpc_id" {
  description = "VPC ID for MSK"
  type        = string
  default = "vpc-03ddd7fd3163cc23a"
}

variable "subnet_ids" {
  description = "Subnets for MSK brokers"
  type        = list(string)
  default = [ "subnet-0b122c2762f8a9810", "subnet-04376b3769122e838" ]
}

variable "create_sec_grp" {
  description = "Flag to create a new security group"
  type        = bool
  default     = true
}

variable "broker_sec_grp_ids" {
  description = "Additional security group IDs for MSK brokers"
  type        = list(string)
  default     = []
}

variable "ingress_rules" {
  description = "Ingress rules for MSK security group"
  type = list(object({
    port               = number
    cidr_blocks        = list(string)
    security_group_ids = list(string)
  }))
  default = [
    {
    port               = 9092
    cidr_blocks        = ["10.0.0.0/16"]
    security_group_ids = []
  }
  ]
}

# MSK Cluster
variable "kafka_version" {
  description = "Kafka version to use"
  type        = string
  default     = "3.8.x"
}

variable "brokers_count" {
  description = "Number of Kafka brokers"
  type        = number
  default     = 2
}

variable "broker_instance_type" {
  description = "Instance type for Kafka brokers"
  type        = string
  default     = "kafka.m5.large"
}

variable "broker_volume_size" {
  description = "EBS volume size for Kafka brokers"
  type        = number
  default     = 1000
}

# Encryption
variable "create_kms_key" {
  description = "Whether to create a new KMS key"
  type        = bool
  default     = true
}

variable "encryption_at_rest_kms_key_arn" {
  description = "KMS Key ARN (used if create_kms_key is false)"
  type        = string
  default     = ""
}

variable "encryption_in_cluster_enabled" {
  description = "Enable in-cluster encryption"
  type        = bool
  default     = true
}

variable "client_broker_protocol" {
  description = "Client-broker encryption protocol (TLS or PLAINTEXT or TLS_PLAINTEXT)"
  type        = string
  default     = "TLS"
}

# Server Properties
variable "server_properties" {
  description = "Kafka server properties map"
  type        = map(string)
  default     = {}
}

# Monitoring & Logging
variable "enhanced_monitoring" {
  description = "Enhanced monitoring level"
  type        = string
  default     = "PER_BROKER"
}

variable "enable_open_monitoring" {
  description = "Enable Prometheus JMX and Node Exporter"
  type        = bool
  default     = false
}

variable "cloudwatch_logs_enabled" {
  description = "Enable CloudWatch logs"
  type        = bool
  default     = false
}

variable "cloudwatch_logs_log_group" {
  description = "CloudWatch log group name"
  type        = string
  default     = ""
}

variable "firehose_logs_enabled" {
  description = "Enable Firehose logs"
  type        = bool
  default     = false
}

variable "firehose_delivery_stream" {
  description = "Firehose delivery stream name"
  type        = string
  default     = ""
}

variable "s3_logs_enabled" {
  description = "Enable S3 logs"
  type        = bool
  default     = false
}

variable "s3_logs_bucket" {
  description = "S3 bucket name for logs"
  type        = string
  default     = ""
}

variable "s3_logs_prefix" {
  description = "Prefix for S3 logs"
  type        = string
  default     = ""
}

# Authentication
variable "client_sasl_scram_enabled" {
  description = "Enable SASL SCRAM authentication"
  type        = bool
  default     = false
}

variable "aws_secret_manager_arn" {
  description = "List of AWS Secrets Manager ARNs for SASL"
  type        = list(string)
  default     = []
}

# Autoscaling
variable "autoscaling_enabled" {
  description = "Enable MSK volume autoscaling"
  type        = bool
  default     = false
}

variable "max_volume_size" {
  description = "Maximum volume size in GiB"
  type        = number
  default     = 2000
}

variable "scaling_target_threshold" {
  description = "Utilization threshold for auto scaling"
  type        = number
  default     = 70
}


variable "egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    port               = number
    protocol           = string
    cidr_blocks        = list(string)
    security_group_ids = list(string)
  }))
  default = [
      {
    port               = 0
    protocol           = "-1"
    cidr_blocks        = ["0.0.0.0/0"]
    security_group_ids = []
  }
  ]
}


variable "client_sasl_iam_enabled" {
  description = "Enable IAM-based SASL authentication"
  type        = bool
  default     = false
}

variable "client_tls_enabled" {
  description = "Enable TLS client authentication using ACM certificates"
  type        = bool
  default     = false
}

variable "acm_certificate_arns" {
  type    = list(string)
  default = ["arn:aws:acm-pca:us-east-1:123456789012:certificate-authority/abcd1234-abcd-1234-abcd-1234abcd5678"]
}
variable "client_unauthenticated_enabled" {
  description = "Enable unauthenticated access to the MSK cluster"
  type        = bool
  default     = false
}




variable "env" {
  type = string
  default = "dev"
  
}

variable "owner" {
  type = string
  default = "opstree"
}

variable "app" {
  type = string
  default = "otcloud-kit"
  
}


