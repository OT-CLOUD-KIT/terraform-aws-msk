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
  description = "Environment short name. Must be one of: d (dev), p (prod), q (qa), s (stage), g (global)."
  type        = string
  default     = "d"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "bu" {
  description = "Business unit name (e.g., pcs, ultrasound). Max 5 characters."
  type        = string
  default     = "ot"
  validation {
    condition     = length(var.bu) <= 5
    error_message = "The business unit name must be less than or equal to 5 characters."
  }
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 6 characters."
  type        = string
  default     = "bp"
  validation {
    condition     = length(var.app) <= 6
    error_message = "The app name must be less than or equal to 6 characters."
  }
}

variable "resource" {
  description = "Resource name (e.g., eks, efs, ecr). Max 15 characters."
  type        = string
  default     = "instance"
  validation {
    condition     = length(var.resource) <= 15
    error_message = "The resource name must be less than or equal to 15 characters."
  }
}

variable "tenant" {
  description = "Tenant name (e.g., app1, app2). Max 6 characters."
  type        = string
  default     = ""
  validation {
    condition     = length(var.tenant) <= 6
    error_message = "The tenant name must be less than or equal to 6 characters."
  }
}

variable "enabled_features" {
  type    = list(string)
  default = []
}

variable "random_alphanumeric_len" {
  description = "The length of random alphanumeric string desired. Min: 1, Max: 4."
  type        = number
  default     = 4
  validation {
    condition     = var.random_alphanumeric_len >= 1 && var.random_alphanumeric_len <= 4
    error_message = "The length must be between 1 and 4."
  }
}

variable "special" {
  description = "Include special characters like !@#$%&*()-_=+[]{}<>:? in the generated name."
  type        = bool
  default     = false
}

variable "upper" {
  description = "Include uppercase characters in the generated name."
  type        = bool
  default     = false
}

variable "number" {
  description = "Include numbers in the generated name."
  type        = bool
  default     = true
}

variable "gen_no_of_names" {
  description = "Number of names to generate."
  type        = number
  default     = 1
}

variable "team" {
  description = "The email address of the team who owns the application, ex:digitalops@gehealthcare.com"
  type        = string
  default     = "infra"
}

variable "program" {
  description = "Name of the Program, For ex: OT, BP etc."
  type        = string
  default     = "ot"
}

variable "region" {
  type    = string
  default = "us-east-1"
}
