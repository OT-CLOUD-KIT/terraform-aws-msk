data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_availability_zones" "azs" {
  state = var.state
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:${var.kafka_tag_key}"
    values = [var.kafka_tag_value]
  }
}

data "aws_security_groups" "sg" {
  filter {
    name   = "tag:${var.kafka_tag_key}"
    values = [var.kafka_tag_value]
  }
}