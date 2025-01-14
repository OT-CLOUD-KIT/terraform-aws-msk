module "msk" {
  source             = "../../"
  vpc_id             = "vpc-xxxxxx"
  subnet_ids         = ["subnet-yyyyyy", "subnet-xxxxxx"]
  brokers_count      = 2
  kafka_version      = "3.5.1"
  broker_sec_grp_ids = ["sg-xxxxxx"]
  create_kms_key     = true
}
