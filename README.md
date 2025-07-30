# Terraform AWS MSK (Managed Streaming for Apache Kafka) Module


A terraform module which creates AWS Managed Kafka Service (MSK) with best practices in terms of network security, cost and optimization. Here are the list of features in this MSK terraform:-

- MSK cluster setup with security group controls.
- KMS encryption support for cluster.
- Monitoring support with JMX and node exporter.
- Logging support for Cloudwatch, Firebase and S3.
- Client authentication support with AWS secret manager.
- Kafka MSK scaling with AWS app autoscaling.

---

## Architecture
![](https://raw.githubusercontent.com/OT-CLOUD-KIT/terraform-aws-msk/refs/heads/main/assets/msk-architecture.gif)




---

## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|

___





##  Usage

```hcl
module "msk" {
  source = "OT-CLOUD-KIT/terraform-aws-msk"

  name                         = "demo-msk"
  vpc_id                       = "vpc-0a1234567890abcd"
  subnet_ids                   = ["subnet-01abc", "subnet-02abc"]

  kafka_version                = "3.8.x"
  brokers_count                = 2
  broker_instance_type         = "kafka.m5.large"
  broker_volume_size           = 1000

  create_sec_grp               = true
  broker_sec_grp_ids           = []

  create_kms_key               = true
  encryption_in_cluster_enabled = true
  client_broker_protocol       = "TLS"

  server_properties = {
    "auto.create.topics.enable" = "true"
    "num.partitions"            = "3"
  }

  enhanced_monitoring          = "PER_BROKER"
  enable_open_monitoring       = false

  cloudwatch_logs_enabled      = false
  firehose_logs_enabled        = false
  s3_logs_enabled              = false

  client_sasl_scram_enabled    = false
  client_sasl_iam_enabled      = false
  client_tls_enabled           = false
  client_unauthenticated_enabled = true

  aws_secret_manager_arn       = []
  acm_certificate_arns         = []

  autoscaling_enabled          = false
  max_volume_size              = 2000
  scaling_target_threshold     = 70

  ingress_rules = [
    {
      port               = 9092
      cidr_blocks        = ["10.0.0.0/16"]
      security_group_ids = []
    }
  ]

 
}

```

## Resources

| Name                                                                                                                                             | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws\_security\_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                               | resource |
| [aws\_msk\_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_configuration)                         | resource |
| [aws\_kms\_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)                                             | resource |
| [aws\_msk\_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster)                                     | resource |
| [aws\_msk\_scram\_secret\_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_scram_secret_association) | resource |
| [aws\_appautoscaling\_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target)                 | resource |
| [aws\_appautoscaling\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy)                 | resource |


___

## Input

| Name                                                                                                                          | Description                                                                | Type           | Default        | Required |
| ----------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | -------------- | -------------- | :------: |
| <a name="input_name"></a> [name](#input_name)                                                                                 | Name prefix for MSK resources                                              | `string`       | n/a            |    yes   |
| <a name="input_vpc_id"></a> [vpc\_id](#input_vpc_id)                                                                          | ID of the VPC to deploy MSK into                                           | `string`       | n/a            |    yes   |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input_subnet_ids)                                                              | List of private subnet IDs for brokers                                     | `list(string)` | n/a            |    yes   |
| <a name="input_create_sec_grp"></a> [create\_sec\_grp](#input_create_sec_grp)                                                 | Whether to create a new security group                                     | `bool`         | `true`         |    no    |
| <a name="input_broker_sec_grp_ids"></a> [broker\_sec\_grp\_ids](#input_broker_sec_grp_ids)                                    | Additional security group IDs to attach                                    | `list(string)` | `[]`           |    no    |
| <a name="input_kafka_version"></a> [kafka\_version](#input_kafka_version)                                                     | Kafka version for MSK cluster                                              | `string`       | n/a            |    yes   |
| <a name="input_brokers_count"></a> [brokers\_count](#input_brokers_count)                                                     | Number of broker nodes                                                     | `number`       | n/a            |    yes   |
| <a name="input_broker_instance_type"></a> [broker\_instance\_type](#input_broker_instance_type)                               | EC2 instance type for broker nodes                                         | `string`       | n/a            |    yes   |
| <a name="input_broker_volume_size"></a> [broker\_volume\_size](#input_broker_volume_size)                                     | EBS volume size (GiB) for broker nodes                                     | `number`       | n/a            |    yes   |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input_create_kms_key)                                                 | Whether to create a new KMS key for encryption                             | `bool`         | `true`         |    no    |
| <a name="input_encryption_in_cluster_enabled"></a> [encryption\_in\_cluster\_enabled](#input_encryption_in_cluster_enabled)   | Enable encryption within the MSK cluster                                   | `bool`         | `true`         |    no    |
| <a name="input_client_broker_protocol"></a> [client\_broker\_protocol](#input_client_broker_protocol)                         | Client-broker communication protocol (`TLS`, `PLAINTEXT`, `TLS_PLAINTEXT`) | `string`       | `"TLS"`        |    no    |
| <a name="input_server_properties"></a> [server\_properties](#input_server_properties)                                         | Kafka server properties                                                    | `map(string)`  | n/a            |    yes   |
| <a name="input_enhanced_monitoring"></a> [enhanced\_monitoring](#input_enhanced_monitoring)                                   | Enhanced monitoring mode                                                   | `string`       | `"PER_BROKER"` |    no    |
| <a name="input_enable_open_monitoring"></a> [enable\_open\_monitoring](#input_enable_open_monitoring)                         | Enable Prometheus Open Monitoring                                          | `bool`         | `false`        |    no    |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input_cloudwatch_logs_enabled)                      | Enable CloudWatch logs                                                     | `bool`         | `false`        |    no    |
| <a name="input_cloudwatch_logs_log_group"></a> [cloudwatch\_logs\_log\_group](#input_cloudwatch_logs_log_group)               | CloudWatch log group name                                                  | `string`       | `""`           |    no    |
| <a name="input_firehose_logs_enabled"></a> [firehose\_logs\_enabled](#input_firehose_logs_enabled)                            | Enable Kinesis Firehose logs                                               | `bool`         | `false`        |    no    |
| <a name="input_s3_logs_enabled"></a> [s3\_logs\_enabled](#input_s3_logs_enabled)                                              | Enable S3 logs                                                             | `bool`         | `false`        |    no    |
| <a name="input_s3_logs_bucket"></a> [s3\_logs\_bucket](#input_s3_logs_bucket)                                                 | S3 bucket for logs (if S3 logging is enabled)                              | `string`       | `""`           |    no    |
| <a name="input_s3_logs_prefix"></a> [s3\_logs\_prefix](#input_s3_logs_prefix)                                                 | Prefix for S3 logs                                                         | `string`       | `""`           |    no    |
| <a name="input_client_sasl_scram_enabled"></a> [client\_sasl\_scram\_enabled](#input_client_sasl_scram_enabled)               | Enable SASL/SCRAM authentication                                           | `bool`         | `false`        |    no    |
| <a name="input_client_sasl_iam_enabled"></a> [client\_sasl\_iam\_enabled](#input_client_sasl_iam_enabled)                     | Enable IAM-based SASL authentication                                       | `bool`         | `false`        |    no    |
| <a name="input_client_tls_enabled"></a> [client\_tls\_enabled](#input_client_tls_enabled)                                     | Enable TLS authentication with ACM certs                                   | `bool`         | `false`        |    no    |
| <a name="input_client_unauthenticated_enabled"></a> [client\_unauthenticated\_enabled](#input_client_unauthenticated_enabled) | Enable unauthenticated clients                                             | `bool`         | `true`         |    no    |
| <a name="input_acm_certificate_arns"></a> [acm\_certificate\_arns](#input_acm_certificate_arns)                               | List of ACM certificate ARNs for TLS                                       | `list(string)` | `[]`           |    no    |
| <a name="input_aws_secret_manager_arn"></a> [aws\_secret\_manager\_arn](#input_aws_secret_manager_arn)                        | List of Secret Manager ARNs for SASL                                       | `list(string)` | `[]`           |    no    |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input_autoscaling_enabled)                                   | Enable MSK autoscaling                                                     | `bool`         | `false`        |    no    |
| <a name="input_max_volume_size"></a> [max\_volume\_size](#input_max_volume_size)                                              | Max EBS volume size (GiB) for autoscaling                                  | `number`       | `2000`         |    no    |
| <a name="input_scaling_target_threshold"></a> [scaling\_target\_threshold](#input_scaling_target_threshold)                   | Target threshold for storage autoscaling                                   | `number`       | `70`           |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                 | Tags to apply to all MSK resources                                         | `map(string)`  | `{}`           |    no    |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input_ingress_rules)                                                     | List of ingress rules to apply to security group                           | `list(object)` | n/a            |    yes   |

___


## Output 

| Name                                                                                                  | Description                                   |
| ----------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| <a name="output_msk_cluster_arn"></a> [msk\_cluster\_arn](#output_msk_cluster_arn)                    | ARN of the MSK Cluster                        |
| <a name="output_msk_cluster_name"></a> [msk\_cluster\_name](#output_msk_cluster_name)                 | Name of the MSK Cluster                       |
| <a name="output_msk_security_group_id"></a> [msk\_security\_group\_id](#output_msk_security_group_id) | ID of the created security group (if created) |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output_kms_key_arn)                                | ARN of the KMS key used for encryption        |


___


## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)


