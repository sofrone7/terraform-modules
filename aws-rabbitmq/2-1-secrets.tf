locals {
  mq_admin_cred = {
    admin_password = random_password.admin.result
  }
}

resource "random_password" "admin" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "mq_admin_cred" {
  name = "mq-admin-cred-${var.rabbitmq_broker_name}"
}

resource "aws_secretsmanager_secret_version" "mq_admin_cred" {
  secret_id     = aws_secretsmanager_secret.mq_admin_cred.id
  secret_string = jsonencode(local.mq_admin_cred)
}