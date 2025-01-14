module "msk" {
  source         = "../../"
  vpc_id         = "vpc-xxxxxx"
  subnet_ids     = ["subnet-yyyyyy", "subnet-xxxxxx"]
  brokers_count  = 2
  kafka_version  = "3.5.1"
  create_sec_grp = true

  ingress_rules = {
    "plaintext" = {
      port = "9092"
      cidr_blocks = [
        "10.0.0.0/8"
      ]
    }
  }
  create_kms_key = true
}
