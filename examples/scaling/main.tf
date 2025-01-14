module "msk" {
  source                         = "../../"
  vpc_id                         = "vpc-xxxxxx"
  subnet_ids                     = ["subnet-yyyyyy", "subnet-xxxxxx"]
  brokers_count                  = 2
  broker_sec_grp_ids             = ["sg-xxxxxx"]
  encryption_at_rest_kms_key_arn = "arn:kms:key"

  autoscaling_enabled      = true
  max_volume_size          = 1500
  scaling_target_threshold = 75
}
