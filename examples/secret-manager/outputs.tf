output "msk_sec_grp_id" {
  description = "ID of the MSK security group."
  value       = module.msk[*].msk_sec_grp_id
}

output "msk_config_arn" {
  description = "ARN for MSK configuration."
  value       = module.msk.msk_config_arn
}

output "cluster_uuid" {
  description = "UUID of the MSK cluster."
  value       = module.msk.cluster_uuid
}

output "bootstrap_brokers" {
  description = "Comma separated list of one or more hostname:port pairs of kafka brokers."
  value       = module.msk.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "One or more DNS names (or IP addresses) and TLS port pairs."
  value       = module.msk.bootstrap_brokers_tls
}

output "zookeeper_connect_string" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster."
  value       = module.msk.zookeeper_connect_string
}

output "zookeeper_connect_string_tls" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster via TLS. "
  value       = module.msk.zookeeper_connect_string_tls
}

output "kms_key_arn" {
  description = "ARN for the KMS key created for encryption and decryption."
  value       = module.msk[*].kms_key_arn
}

output "msk_scaling_target_arn" {
  description = "ARN for MSK app target scaling."
  value       = module.msk[*].msk_scaling_target_arn
}

output "msk_scaling_target_policy_arn" {
  description = "ARN for MSK app target policy scaling."
  value       = module.msk[*].msk_scaling_target_policy_arn
}
