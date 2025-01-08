output "msk_sec_grp_id" {
  description = "ID of the MSK security group."
  value       = aws_security_group.msk_sec_grp[*].id
}

output "msk_config_arn" {
  description = "ARN for MSK configuration."
  value       = aws_msk_configuration.msk_config.arn
}

output "cluster_uuid" {
  description = "UUID of the MSK cluster."
  value       = aws_msk_cluster.msk.cluster_uuid
}

output "bootstrap_brokers" {
  description = "Comma separated list of one or more hostname:port pairs of kafka brokers."
  value       = aws_msk_cluster.msk.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "One or more DNS names (or IP addresses) and TLS port pairs."
  value       = aws_msk_cluster.msk.bootstrap_brokers_tls
}

output "zookeeper_connect_string" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster."
  value       = aws_msk_cluster.msk.zookeeper_connect_string
}

output "zookeeper_connect_string_tls" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster via TLS. "
  value       = aws_msk_cluster.msk.zookeeper_connect_string_tls
}

output "kms_key_arn" {
  description = "ARN for the KMS key created for encryption and decryption"
  value       = aws_kms_key.kms[*].arn
}
