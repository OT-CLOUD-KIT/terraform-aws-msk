name                        = "demo-msk"
vpc_id                      = "vpc-03ddd7fd3163cc23a"
subnet_ids                  = ["subnet-0b122c2762f8a9810", "subnet-04376b3769122e838"]
create_sec_grp              = true
broker_sec_grp_ids          = []
kafka_version               = "3.8.x"
brokers_count               = 2
broker_instance_type        = "kafka.m5.large"
broker_volume_size          = 1000
create_kms_key              = true
encryption_in_cluster_enabled = true
client_broker_protocol      = "TLS"

server_properties = {
  "auto.create.topics.enable" = "true"
  "num.partitions"            = "3"
}

enhanced_monitoring         = "PER_BROKER"
enable_open_monitoring      = false

cloudwatch_logs_enabled     = false
cloudwatch_logs_log_group   = ""
firehose_logs_enabled       = false
s3_logs_enabled             = false

client_sasl_scram_enabled   = false
aws_secret_manager_arn      = []

autoscaling_enabled         = false
max_volume_size             = 2000
scaling_target_threshold    = 70


ingress_rules = [
  {
    port               = 9092
    cidr_blocks        = ["10.0.0.0/16"]
    security_group_ids = []
  }
]




client_sasl_iam_enabled        = false
client_tls_enabled             = false
client_unauthenticated_enabled = true
acm_certificate_arns = []


egress_rules = [
  {
    port               = 0
    protocol           = "-1"
    cidr_blocks        = ["0.0.0.0/0"]
    security_group_ids = []
  }
]


random_alphanumeric_len = 4

bu       = "ot"
app      = "bp"
env      = "d"
resource = "msk"
tenant   = ""

special = false
upper   = false
number  = true

gen_no_of_names = 1

team    = "infra"
program = "ot"

