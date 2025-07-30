output "msk_cluster_arn" {
  description = "ARN of the MSK Cluster"
  value       = aws_msk_cluster.msk.arn
}

output "msk_cluster_name" {
  description = "Name of the MSK Cluster"
  value       = aws_msk_cluster.msk.cluster_name
}

output "msk_security_group_id" {
  description = "ID of the created security group (if created)"
  value       = var.create_sec_grp ? aws_security_group.msk_sec_grp[0].id : null
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for encryption"
  value       = var.create_kms_key ? aws_kms_key.kms[0].arn : var.encryption_at_rest_kms_key_arn
}
