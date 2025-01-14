module "msk" {
  source                         = "../../"
  vpc_id                         = "vpc-xxxxxx"
  subnet_ids                     = ["subnet-yyyyyy", "subnet-xxxxxx"]
  brokers_count                  = 2
  broker_sec_grp_ids             = ["sg-xxxxxx"]
  encryption_at_rest_kms_key_arn = "arn:kms:key"

  enable_open_monitoring = true
  s3_logs_enabled        = true
  s3_logs_bucket         = "msk-logs"
  s3_logs_prefix         = "msk-stage"
}
