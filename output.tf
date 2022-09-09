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

output "vpc" {
  description = "vpc id for kafka resource"
  value       = data.aws_vpc.vpc.id
}

output "sg" {
  description = "security groups id for kafka resource"
  value       = data.aws_security_groups.sg.ids
}

output "subnet_ids" {
  description = "subnet ids for kafka resource"
  value       = data.aws_subnet_ids.subnet_ids.ids
}