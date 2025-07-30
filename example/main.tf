module "standard_tags" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-standard-tagging.git?ref=dev"

  bu      = var.bu
  program = var.program
  app     = var.app
  team    = var.team
  region  = var.region
  env     = var.env
}

module "naming" {
  source   = "git@github.com:OT-CLOUD-KIT/terraform-aws-naming.git?ref=dev"
  bu       = var.bu
  env      = var.env
  app      = var.app
  resource = var.resource
}



module "msk" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-msk.git?ref=Feature" 

  name                            = var.name
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  create_sec_grp                  = var.create_sec_grp
  broker_sec_grp_ids              = var.broker_sec_grp_ids
  kafka_version                   = var.kafka_version
  brokers_count                   = var.brokers_count
  broker_instance_type            = var.broker_instance_type
  broker_volume_size              = var.broker_volume_size
  create_kms_key                  = var.create_kms_key
  encryption_in_cluster_enabled   = var.encryption_in_cluster_enabled
  client_broker_protocol          = var.client_broker_protocol
  
  bu      = var.bu
  program = var.program
  app     = var.app
  env     = var.env
  team    = var.team
  region  = var.region
  server_properties               = var.server_properties

  enhanced_monitoring             = var.enhanced_monitoring
  enable_open_monitoring          = var.enable_open_monitoring

  cloudwatch_logs_enabled         = var.cloudwatch_logs_enabled
  cloudwatch_logs_log_group       = var.cloudwatch_logs_log_group
  firehose_logs_enabled           = var.firehose_logs_enabled
  firehose_delivery_stream        = var.firehose_delivery_stream
  s3_logs_enabled                 = var.s3_logs_enabled
  s3_logs_bucket                  = var.s3_logs_bucket
  s3_logs_prefix                  = var.s3_logs_prefix

  client_sasl_scram_enabled       = var.client_sasl_scram_enabled
  client_sasl_iam_enabled         = var.client_sasl_iam_enabled
  client_tls_enabled              = var.client_tls_enabled
  client_unauthenticated_enabled  = var.client_unauthenticated_enabled
  acm_certificate_arns            = var.acm_certificate_arns
  aws_secret_manager_arn          = var.aws_secret_manager_arn

  autoscaling_enabled             = var.autoscaling_enabled
  max_volume_size                 = var.max_volume_size
  scaling_target_threshold        = var.scaling_target_threshold

  ingress_rules                   = var.ingress_rules
egress_rules =  var.egress_rules
  encryption_at_rest_kms_key_arn  = var.encryption_at_rest_kms_key_arn
}
