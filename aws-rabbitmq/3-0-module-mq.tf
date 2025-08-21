resource "aws_mq_broker" "broker" {

  broker_name        = var.rabbitmq_broker_name
  engine_type        = "RabbitMQ"
  engine_version     = var.rabbitmq_engine_version
  host_instance_type = var.rabbitmq_host_instance_type
  deployment_mode    = var.rabbitmq_deployment_mode
  user {
    username = var.rabbitmq_username
    password = jsondecode(data.aws_secretsmanager_secret_version.current_secrets.secret_string)["admin_password"]
  }

  subnet_ids = var.rabbitmq_subnet_ids
  tags = merge(local.fixed_tags, var.rabbitmq_broker_extra_tags)
  #A completar con los tags correspondientes (backup, etc.)

  security_groups = concat([module.rabbitmq_sg.security_group_id], var.rabbitmq_security_groups)

  apply_immediately          = var.rabbitmq_apply_immediately
  auto_minor_version_upgrade = var.rabbitmq_auto_minor_version_upgrade
  publicly_accessible        = var.rabbitmq_publicly_accessible
  authentication_strategy = var.rabbitmq_authentication_strategy

  encryption_options {
    use_aws_owned_key = var.rabbitmq_use_aws_owned_key
    kms_key_id        = var.rabbitmq_kms_key_id
  }

  logs {
    general = true
    //audit   = false
  }
  
  maintenance_window_start_time {
    day_of_week = var.rabbitmq_day_of_week
    time_of_day = var.rabbitmq_time_of_day
    time_zone   = var.rabbitmq_time_zone
  }
}




