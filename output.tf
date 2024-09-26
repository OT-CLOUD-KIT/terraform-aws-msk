output "zookeeper_connect_string" {
  description = "zookeeper connect string for kafka resource"
  value       = aws_msk_cluster.msk_cluster.zookeeper_connect_string 
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers_tls 
}