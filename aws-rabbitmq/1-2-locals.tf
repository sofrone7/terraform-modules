locals {
  fixed_tags = {
    Name              = var.rabbitmq_broker_name
  }

  project               = var.rabbitmq_project
  environment           = var.rabbitmq_environment

}
