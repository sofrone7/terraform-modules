data "aws_region" "current" {}

data "aws_ssm_parameter" "account_private_hosted_zone" {
  name = "/route53/account_private_hosted_zone/id"
}

data "aws_secretsmanager_secret" "env_secrets" {
  name = "mq-admin-cred-${var.rabbitmq_broker_name}"
  depends_on = [
    aws_secretsmanager_secret.mq_admin_cred
  ]
}
data "aws_secretsmanager_secret_version" "current_secrets" {
  secret_id = data.aws_secretsmanager_secret.env_secrets.id
  depends_on = [
    aws_secretsmanager_secret.mq_admin_cred,
    aws_secretsmanager_secret_version.mq_admin_cred
  ]
}

data "dns_a_record_set" "mq_private_ips" {
  host = "${replace(aws_mq_broker.broker.instances.0.console_url, "https://", "")}"
}