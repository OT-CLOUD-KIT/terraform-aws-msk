variable "name" {
  type        = string
  description = "Base name used for MSK resources."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where MSK will be deployed."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for MSK brokers."
}

variable "create_sec_grp" {
  type        = bool
  default     = true
  description = "Whether to create a new security group for MSK."
}

variable "broker_sec_grp_ids" {
  type        = list(string)
  description = "List of additional security group IDs for MSK brokers."
  default     = []
}

variable "kafka_version" {
  type        = string
  description = "Kafka version for MSK cluster (e.g. 3.5.1, 3.8.x)."
}

variable "brokers_count" {
  type        = number
  description = "Number of broker nodes."
}

variable "broker_instance_type" {
  type        = string
  description = "EC2 instance type for broker nodes (e.g. kafka.m5.large)."
}

variable "broker_volume_size" {
  type        = number
  description = "EBS volume size (in GiB) per broker."
}

variable "create_kms_key" {
  type        = bool
  default     = true
  description = "Whether to create a new KMS key for encryption."
}

variable "encryption_in_cluster_enabled" {
  type        = bool
  default     = true
  description = "Enable in-cluster encryption."
}

variable "client_broker_protocol" {
  type        = string
  default     = "TLS"
  description = "Client-broker encryption protocol: TLS, PLAINTEXT, or TLS_PLAINTEXT."
}

variable "server_properties" {
  type        = map(string)
  description = "Map of Kafka server.properties settings."
}

variable "enhanced_monitoring" {
  type        = string
  default     = "PER_BROKER"
  description = "Enhanced monitoring mode: DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER, etc."
}

variable "enable_open_monitoring" {
  type        = bool
  default     = false
  description = "Enable Prometheus open monitoring."
}

variable "cloudwatch_logs_enabled" {
  type        = bool
  default     = false
  description = "Enable CloudWatch logging for broker logs."
}

variable "cloudwatch_logs_log_group" {
  type        = string
  default     = ""
  description = "CloudWatch log group name."
}

variable "firehose_logs_enabled" {
  type        = bool
  default     = false
  description = "Enable Firehose logging."
}

variable "firehose_delivery_stream" {
  type        = string
  default     = ""
  description = "Firehose delivery stream name."
}

variable "s3_logs_enabled" {
  type        = bool
  default     = false
  description = "Enable S3 logging."
}

variable "s3_logs_bucket" {
  type        = string
  default     = ""
  description = "S3 bucket for broker logs."
}

variable "s3_logs_prefix" {
  type        = string
  default     = ""
  description = "S3 prefix/folder path for logs."
}

variable "client_sasl_scram_enabled" {
  type        = bool
  default     = false
  description = "Enable SASL/SCRAM authentication."
}

variable "client_sasl_iam_enabled" {
  type        = bool
  default     = false
  description = "Enable IAM authentication."
}

variable "client_tls_enabled" {
  type        = bool
  default     = false
  description = "Enable TLS mutual authentication."
}

variable "client_unauthenticated_enabled" {
  type        = bool
  default     = true
  description = "Allow unauthenticated access to the cluster."
}

variable "acm_certificate_arns" {
  type        = list(string)
  default     = []
  description = "List of ACM certificate ARNs for TLS authentication."
}

variable "aws_secret_manager_arn" {
  type        = list(string)
  default     = []
  description = "List of Secrets Manager ARNs for SASL/SCRAM secrets."
}

variable "autoscaling_enabled" {
  type        = bool
  default     = false
  description = "Enable auto-scaling for broker storage."
}

variable "max_volume_size" {
  type        = number
  default     = 2000
  description = "Maximum EBS volume size for auto-scaling."
}

variable "scaling_target_threshold" {
  type        = number
  default     = 70
  description = "Threshold percentage for triggering auto-scaling."
}



variable "ingress_rules" {
  type = list(object({
    port               = number
    cidr_blocks        = list(string)
    security_group_ids = list(string)
  }))
  description = "List of ingress rules for the security group."
}

variable "encryption_at_rest_kms_key_arn" {
  type        = string
  default     = ""
  description = "Custom KMS key ARN for encryption at rest if not creating one."
}


variable "egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    port               = number
    protocol           = string
    cidr_blocks        = list(string)
    security_group_ids = list(string)
  }))
  default = []
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
variable "region" {
  type    = string
  default = "us-east-1"
}
