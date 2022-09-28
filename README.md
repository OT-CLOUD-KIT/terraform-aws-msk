#  Amazon MSK (Amazon Managed Streaming for Apache Kafka)

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/200x100/https://www.opstree.com/images/og_image8.jpg

* Amazon Managed Streaming for Apache Kafka (Amazon MSK) is a fully managed AWS streaming data service makes it easy for you to build and run applications that use Apache Kafka to process streaming data without needing to become an expert in operating Apache Kafka clusters.
* Amazon MSK continuously monitors server health and automatically replaces servers when they fail, automates server patching, and operates highly available ZooKeeper nodes as a part of the service at no additional cost. 

## Usage


```hcl
data "template_file" "msk-custom-configuration" {
  template = file("msk-custom-configuration.json.tpl")
  vars = {
    auto_create_topics_enable        = var.kafka_custom_config_auto_create_topics
    delete_topic_enable              = var.kafka_custom_config_delete_topics
    default_replication_factor       = var.kafka_custom_config_default_replication_factor
    min_insync_replicas              = var.kafka_custom_config_min_insync_replicas
    num_io_threads                   = var.kafka_custom_config_num_io_threads
    num_network_threads              = var.kafka_custom_config_num_network_threads
    num_partitions                   = var.kafka_custom_config_num_partitions
    num_replica_fetchers             = var.kafka_custom_config_num_replica_fetchers
    socket_request_max_bytes         = var.kafka_custom_config_socket_request_max_bytes
    unclean_leader_election_enable   = var.kafka_custom_config_unclean_leader_election_enable
    offsets_topic_replication_factor = var.kafka_custom_config_offsets_topic_replication_factor
  }
}

module "kafka" {
  source                      = "git::https://github.com/OT-CLOUD-KIT/terraform-aws-msk.git"
  count                       = var.aws_vpc_enable_resource == true ? 1 : 0
  kms_key                     = var.kms_key
  state                       = var.state
  security_group_id           = var.security_group_id 
  subnet_ids                  = var.subnet_ids      
  name_prefix                 = var.name_prefix
  kafka_version               = var.kafka_version
  kafka_versions              = var.kafka_versions
  kafka_broker_number         = var.kafka_broker_number
  kafka_instance_type         = var.kafka_instance_type
  kafka_ebs_volume_size       = var.kafka_ebs_volume_size
  kafka_encryption_in_transit = var.kafka_encryption_in_transit
  kafka_monitoring_level      = var.kafka_monitoring_level
  kafka_custom_config         = data.template_file.msk-custom-configuration.rendered
  tags                        = var.tags
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_vpc_enable_resource |if value is true then resource block will be used and if false then data block will be used| `bool` | `true` | yes |
| kms_key | kms keys available value in the form of a string | `string`  | `""` | no |
| state | availability zone state |  | `"available"` | yes |
| security_group_id  | security group ids in the form of a list of string | `list(string)` | `[]` | yes |
| subnet_ids  | subnet ids in the form of a list of string| `list(string)` | `[]` | yes 
| name_prefix | A prefix used for naming resources (msk cluster) in the form of a string  | `string` | `"example"` | yes |
| kafka_version | Version of Kafka brokers in the form of a string | `string` | `"3.2.0"` | yes |
| kafka_versions | Version of Kafka aws msk configuration in the form of a list of string | `list(string)` | `["3.2.0"]` | yes |
| kafka_broker_number| Kafka brokers per zone in the form of a number |   `number` | `3` | yes |
| kafka_instance_type | Kafka broker instance type in the form of string| `string` | `kafka.m5.large"` | yes |
| kafka_ebs_volume_size| Kafka EBS volume size in GB in the form of a string | `string`|  `"100"` | yes |
| kafka_encryption_in_transit | Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT  | `string` | `"TLS_PLAINTEXT"` | yes |
| kafka_monitoring_level| Property to one of three monitoring levels: DEFAULT, PER_BROKER, or PER_TOPIC_PER_BROKER  | `string` | `"PER_TOPIC_PER_BROKER"`| yes |
|kafka_custom_config| Kafka custom config json file (msk-custom-configuration.json.tpl)| `json` | `""` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | `map(string)` | `<map>` | no |

## Outputs

These defined outputs that can be used within the same service and terraform release.

| Name | Description |
|------|-------------|
| zookeeper_connect_string | zookeeper connect string for kafka resource |
| bootstrap_brokers | Plaintext connection host:port pairs|
| bootstrap_brokers_tls | TLS connection host:port pairs |


## Contributors

![Screenshot from 2022-08-31 11-15-32](https://user-images.githubusercontent.com/98826875/187603118-a9bf0285-01f9-409e-9752-2fec11bc551b.png)


[Shristi Gupta][shristi_homepage]

  [shristi_homepage]: https://gitlab.com/shristi.gupta

  