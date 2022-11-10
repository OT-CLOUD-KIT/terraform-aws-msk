output "zookeeper_connect_string" {
  description = "zookeeper connect string for kafka resource"
  value       = aws_msk_cluster.msk-cluster.zookeeper_connect_string
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = aws_msk_cluster.msk-cluster.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.msk-cluster.bootstrap_brokers_tls
}


## KMS KEY 

output "key_alias_arn" {
  description = "The arn of the key alias"
  value       = aws_kms_alias.key_alias[0].arn
}

output "key_alias_name" {
  description = "The name of the key alias"
  value       = aws_kms_alias.key_alias[0].name
}

output "key_arn" {
  description = "The arn of the key"
  value       = aws_kms_key.kms[0].arn
}

output "key_id" {
  description = "The globally unique identifier for the key"
  value       = aws_kms_key.kms[0].id
}