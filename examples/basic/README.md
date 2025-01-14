## Basic

## Requirements

No requirements.

## Providers

No providers.

## Usage

```shell
$ terraform init
$ terraform plan
$ terraform apply
```

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_msk"></a> [msk](#module\_msk) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers) | Comma separated list of one or more hostname:port pairs of kafka brokers. |
| <a name="output_bootstrap_brokers_tls"></a> [bootstrap\_brokers\_tls](#output\_bootstrap\_brokers\_tls) | One or more DNS names (or IP addresses) and TLS port pairs. |
| <a name="output_cluster_uuid"></a> [cluster\_uuid](#output\_cluster\_uuid) | UUID of the MSK cluster. |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | ARN for the KMS key created for encryption and decryption. |
| <a name="output_msk_config_arn"></a> [msk\_config\_arn](#output\_msk\_config\_arn) | ARN for MSK configuration. |
| <a name="output_msk_scaling_target_arn"></a> [msk\_scaling\_target\_arn](#output\_msk\_scaling\_target\_arn) | ARN for MSK app target scaling. |
| <a name="output_msk_scaling_target_policy_arn"></a> [msk\_scaling\_target\_policy\_arn](#output\_msk\_scaling\_target\_policy\_arn) | ARN for MSK app target policy scaling. |
| <a name="output_msk_sec_grp_id"></a> [msk\_sec\_grp\_id](#output\_msk\_sec\_grp\_id) | ID of the MSK security group. |
| <a name="output_zookeeper_connect_string"></a> [zookeeper\_connect\_string](#output\_zookeeper\_connect\_string) | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster. |
| <a name="output_zookeeper_connect_string_tls"></a> [zookeeper\_connect\_string\_tls](#output\_zookeeper\_connect\_string\_tls) | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster via TLS. |
