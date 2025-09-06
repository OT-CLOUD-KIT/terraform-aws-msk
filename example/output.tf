output "msk_cluster_arn" {
  description = "ARN of the MSK Cluster"
  value       = module.msk.msk_cluster_arn
}

output "msk_cluster_name" {
  description = "Name of the MSK Cluster"
  value       = module.msk.msk_cluster_name
}

output "msk_security_group_id" {
  description = "ID of the created security group (if created)"
  value       = module.msk.msk_security_group_id
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for encryption"
  value       = module.msk.kms_key_arn
}
