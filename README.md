## Terraform AWS MSK

A terraform module which creates AWS Managed Kafka Service (MSK) with best practices in terms of network security, cost and optimization. Here are the list of features in this MSK terraform:-

- MSK cluster setup with security group controls.
- KMS encryption support for cluster.
- Monitoring support with JMX and node exporter.
- Logging support for Cloudwatch, Firebase and S3.
- Client authentication support with AWS secret manager.
- Kafka MSK scaling with AWS app autoscaling.

## Usage

```hcl
module "msk" {
  source  = "OT-CLOUD-KIT/msk/aws"
  # Always point to the latest stable version
  version = "1.0.0"
  vpc_id = "vpc-xxxxxx"

  create_sec_grp = true

  ingress_rules = {
    "plaintext" = {
      port = "9092"
      cidr_blocks = [
        "10.0.0.0/8"
      ]
    }
  }

  server_properties = {
    "log.retention.hours" = 300
    "num.partitions"      = 1
  }

  subnet_ids     = ["subnet-yyyyyy", "subnet-xxxxxx"]
  create_kms_key = true
}
```

## Architecture

![](https://raw.githubusercontent.com/OT-CLOUD-KIT/terraform-aws-msk/refs/heads/main/assets/msk-architecture.gif)

## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |

## Resources

| Name                                                                                                                                                           | Type     |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [aws_appautoscaling_policy.msk_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy)                      | resource |
| [aws_appautoscaling_target.msk_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target)                      | resource |
| [aws_kms_key.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)                                                         | resource |
| [aws_msk_cluster.msk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster)                                                 | resource |
| [aws_msk_configuration.msk_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_configuration)                              | resource |
| [aws_msk_scram_secret_association.scram_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_scram_secret_association) | resource |
| [aws_security_group.msk_sec_grp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                   | resource |

## Inputs

| Name                                                                                                                                                   | Description                                                                                         | Type                                                                                                                                                                          | Default            | Required  |
|--------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------|:---------:|
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled)                                                          | To automatically expand your cluster's storage in response to increased usage, you can enable this. | `bool`                                                                                                                                                                        | `true`             |    no     |
| <a name="input_aws_secret_manager_arn"></a> [aws\_secret\_manager\_arn](#input\_aws\_secret\_manager\_arn)                                             | List of AWS secret manager secrets in which username and password is present.                       | `list(string)`                                                                                                                                                                | `[]`               |    no     |
| <a name="input_broker_instance_type"></a> [broker\_instance\_type](#input\_broker\_instance\_type)                                                     | Specify the instance type to use for the kafka brokers.                                             | `string`                                                                                                                                                                      | `"kafka.m5.large"` |    no     |
| <a name="input_broker_sec_grp_ids"></a> [broker\_sec\_grp\_ids](#input\_broker\_sec\_grp\_ids)                                                         | If security group is externally managed, the IDs can be passed via this variable.                   | `list(string)`                                                                                                                                                                | `[]`               |    no     |
| <a name="input_broker_volume_size"></a> [broker\_volume\_size](#input\_broker\_volume\_size)                                                           | The size in GiB of the EBS volume for the data drive on each broker node.                           | `number`                                                                                                                                                                      | `100`              |    no     |
| <a name="input_brokers_count"></a> [brokers\_count](#input\_brokers\_count)                                                                            | The desired total number of broker nodes in the kafka cluster.                                      | `number`                                                                                                                                                                      | `2`                |    no     |
| <a name="input_client_broker_protocol"></a> [client\_broker\_protocol](#input\_client\_broker\_protocol)                                               | Encryption setting for data in transit between clients and brokers.                                 | `string`                                                                                                                                                                      | `"TLS_PLAINTEXT"`  |    no     |
| <a name="input_client_sasl_scram_enabled"></a> [client\_sasl\_scram\_enabled](#input\_client\_sasl\_scram\_enabled)                                    | Enable SCRAM client authentication via AWS Secrets Manager.                                         | `bool`                                                                                                                                                                        | `false`            |    no     |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled)                                            | Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs.           | `bool`                                                                                                                                                                        | `false`            |    no     |
| <a name="input_cloudwatch_logs_log_group"></a> [cloudwatch\_logs\_log\_group](#input\_cloudwatch\_logs\_log\_group)                                    | Name of the Cloudwatch Log Group to deliver logs to.                                                | `string`                                                                                                                                                                      | `""`               |    no     |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key)                                                                       | Whether to create KMS key for encryption.                                                           | `bool`                                                                                                                                                                        | `false`            |    no     |
| <a name="input_create_sec_grp"></a> [create\_sec\_grp](#input\_create\_sec\_grp)                                                                       | Whether to create MSK security group or not.                                                        | `bool`                                                                                                                                                                        | `false`            |    no     |
| <a name="input_enable_open_monitoring"></a> [enable\_open\_monitoring](#input\_enable\_open\_monitoring)                                               | Set `true` to enable the open monitoring with node and jmx exporter.                                | `bool`                                                                                                                                                                        | `true`             |    no     |
| <a name="input_encryption_at_rest_kms_key_arn"></a> [encryption\_at\_rest\_kms\_key\_arn](#input\_encryption\_at\_rest\_kms\_key\_arn)                 | You may specify a KMS key short ID or ARN.                                                          | `string`                                                                                                                                                                      | `""`               |    no     |
| <a name="input_encryption_in_cluster_enabled"></a> [encryption\_in\_cluster\_enabled](#input\_encryption\_in\_cluster\_enabled)                        | Whether data communication among broker nodes is encrypted.                                         | `bool`                                                                                                                                                                        | `true`             |    no     |
| <a name="input_enhanced_monitoring"></a> [enhanced\_monitoring](#input\_enhanced\_monitoring)                                                          | Specify the desired enhanced MSK CloudWatch monitoring level.                                       | `string`                                                                                                                                                                      | `"DEFAULT"`        |    no     |
| <a name="input_firehose_delivery_stream"></a> [firehose\_delivery\_stream](#input\_firehose\_delivery\_stream)                                         | Name of the Kinesis Data Firehose delivery stream to deliver logs to.                               | `string`                                                                                                                                                                      | `""`               |    no     |
| <a name="input_firehose_logs_enabled"></a> [firehose\_logs\_enabled](#input\_firehose\_logs\_enabled)                                                  | Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose.     | `bool`                                                                                                                                                                        | `false`            |    no     |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules)                                                                            | List of ingress rules which needs to be applied to MSK cluster.                                     | <pre>map(object({<br/>    port               = string<br/>    security_group_ids = optional(list(string))<br/>    cidr_blocks        = optional(list(string))<br/>  }))</pre> | n/a                |    yes    |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version)                                                                            | Kafka version which needs to be provisioned.                                                        | `string`                                                                                                                                                                      | `"3.5.1"`          |    no     |
| <a name="input_max_volume_size"></a> [max\_volume\_size](#input\_max\_volume\_size)                                                                    | Maximum volume size on which MSK can be scaled.                                                     | `number`                                                                                                                                                                      | `1000`             |    no     |
| <a name="input_name"></a> [name](#input\_name)                                                                                                         | Name of the all resources which will be created.                                                    | `string`                                                                                                                                                                      | `"msk"`            |    no     |
| <a name="input_s3_logs_bucket"></a> [s3\_logs\_bucket](#input\_s3\_logs\_bucket)                                                                       | Name of the S3 bucket to deliver logs to.                                                           | `string`                                                                                                                                                                      | `""`               |    no     |
| <a name="input_s3_logs_enabled"></a> [s3\_logs\_enabled](#input\_s3\_logs\_enabled)                                                                    | Indicates whether you want to enable or disable streaming broker logs to S3.                        | `bool`                                                                                                                                                                        | `false`            |    no     |
| <a name="input_s3_logs_prefix"></a> [s3\_logs\_prefix](#input\_s3\_logs\_prefix)                                                                       | Prefix to append to the S3 folder name logs are delivered to.                                       | `string`                                                                                                                                                                      | `""`               |    no     |
| <a name="input_scaling_target_threshold"></a> [scaling\_target\_threshold](#input\_scaling\_target\_threshold)                                         | Percentage of storage used to trigger autoscaled storage increase.                                  | `number`                                                                                                                                                                      | `60`               |    no     |
| <a name="input_server_properties"></a> [server\_properties](#input\_server\_properties)                                                                | All kafka properties which is available in server.properties                                        | `map(string)`                                                                                                                                                                 | `{}`               |    no     |
| <a name="input_storage_autoscaling_disable_scale_in"></a> [storage\_autoscaling\_disable\_scale\_in](#input\_storage\_autoscaling\_disable\_scale\_in) | If the value is true, scale in is disabled.                                                         | `bool`                                                                                                                                                                        | `false`            |    no     |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids)                                                                                     | A list of subnets to connect to in client VPC.                                                      | `list(string)`                                                                                                                                                                | `[]`               |    no     |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                                         | Map of tags to assign to the resources.                                                             | `map(string)`                                                                                                                                                                 | `{}`               |    no     |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id)                                                                                                 | VPC ID in which all resources will be created.                                                      | `string`                                                                                                                                                                      | n/a                |    yes    |

## Outputs

| Name                                                                                                                                | Description                                                                                                          |
|-------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers)                                           | Comma separated list of one or more hostname:port pairs of kafka brokers.                                            |
| <a name="output_bootstrap_brokers_tls"></a> [bootstrap\_brokers\_tls](#output\_bootstrap\_brokers\_tls)                             | One or more DNS names (or IP addresses) and TLS port pairs.                                                          |
| <a name="output_cluster_uuid"></a> [cluster\_uuid](#output\_cluster\_uuid)                                                          | UUID of the MSK cluster.                                                                                             |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn)                                                           | ARN for the KMS key created for encryption and decryption.                                                           |
| <a name="output_msk_config_arn"></a> [msk\_config\_arn](#output\_msk\_config\_arn)                                                  | ARN for MSK configuration.                                                                                           |
| <a name="output_msk_scaling_target_arn"></a> [msk\_scaling\_target\_arn](#output\_msk\_scaling\_target\_arn)                        | ARN for MSK app target scaling.                                                                                      |
| <a name="output_msk_scaling_target_policy_arn"></a> [msk\_scaling\_target\_policy\_arn](#output\_msk\_scaling\_target\_policy\_arn) | ARN for MSK app target policy scaling.                                                                               |
| <a name="output_msk_sec_grp_id"></a> [msk\_sec\_grp\_id](#output\_msk\_sec\_grp\_id)                                                | ID of the MSK security group.                                                                                        |
| <a name="output_zookeeper_connect_string"></a> [zookeeper\_connect\_string](#output\_zookeeper\_connect\_string)                    | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster.         |
| <a name="output_zookeeper_connect_string_tls"></a> [zookeeper\_connect\_string\_tls](#output\_zookeeper\_connect\_string\_tls)      | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster via TLS. |
