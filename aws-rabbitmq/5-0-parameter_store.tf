resource "aws_ssm_parameter" "ssm_parameter_afb_mq_broker_username" {
  name  = "/aws/mq/${var.rabbitmq_broker_name}/username"
  type  = "String"
  value = var.rabbitmq_username
}

resource "aws_ssm_parameter" "ssm_parameter_afb_mq_broker_password" {
  name  = "/aws/mq/${var.rabbitmq_broker_name}/password"
  type  = "SecureString"
  value = jsondecode(data.aws_secretsmanager_secret_version.current_secrets.secret_string)["admin_password"]
}

resource "aws_ssm_parameter" "ssm_parameter_afb_mq_broker_id" {
  name  = "/aws/mq/${var.rabbitmq_broker_name}/id"
  type  = "String"
  value = aws_mq_broker.broker.id
}

resource "aws_ssm_parameter" "ssm_parameter_afb_mq_broker_endpoint" {
  name  = "/aws/mq/${var.rabbitmq_broker_name}/endpoint"
  type  = "String"
  value = "${var.rabbitmq_dns_record_name}.${local.project}-${local.environment}.afbaws.com"
}

resource "aws_ssm_parameter" "ssm_parameter_afb_mq_console_endpoint" {
  name  = "/aws/mq/${var.rabbitmq_broker_name}/console_endpoint"
  type  = "String"
  value = aws_mq_broker.broker.instances.0.console_url
}

resource "aws_ssm_parameter" "ssm_parameter_afb_mq_ips" {
  name  = "/aws/mq/${var.rabbitmq_broker_name}/private_ips"
  type  = "String"
  value = join(",", data.dns_a_record_set.mq_private_ips.addrs)

  depends_on = [
    data.dns_a_record_set.mq_private_ips
  ]
}