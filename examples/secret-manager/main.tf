resource "aws_secretsmanager_secret" "example" {
  name       = "AmazonMSK_example"
  kms_key_id = "arn:kms:key"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = jsonencode({ username = "user", password = "pass" })
}

data "aws_iam_policy_document" "example" {
  statement {
    sid    = "AWSKafkaResourcePolicy"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["kafka.amazonaws.com"]
    }

    actions   = ["secretsmanager:getSecretValue"]
    resources = [aws_secretsmanager_secret.example.arn]
  }
}

resource "aws_secretsmanager_secret_policy" "example" {
  secret_arn = aws_secretsmanager_secret.example.arn
  policy     = data.aws_iam_policy_document.example.json
}

module "msk" {
  source                         = "../../"
  vpc_id                         = "vpc-xxxxxx"
  subnet_ids                     = ["subnet-yyyyyy", "subnet-xxxxxx"]
  brokers_count                  = 2
  kafka_version                  = "3.5.1"
  broker_sec_grp_ids             = ["sg-xxxxxx"]
  encryption_at_rest_kms_key_arn = "arn:kms:key"
  client_sasl_scram_enabled      = true
  aws_secret_manager_arn         = [aws_secretsmanager_secret.example.arn]
}
