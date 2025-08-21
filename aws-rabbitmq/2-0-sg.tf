module "rabbitmq_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.project}-${var.environment}-sg-rabbitmq"
  description = "Security group for RabbitMQ"
  vpc_id      = var.rabbitmq_vpc_id

  create_timeout = "5m"
  delete_timeout = "5m"

  ingress_cidr_blocks = var.rabbitmq_ingress_cidr_blocks
  ingress_rules       = ["rabbitmq-5671-tcp"]
  /*"rabbitmq-4369-tcp",
    "rabbitmq-5671-tcp",
    "rabbitmq-5672-tcp",
    "rabbitmq-15672-tcp",
    "rabbitmq-25672-tcp"
  ] */
  ingress_with_cidr_blocks = [
    {
      from_port   = 15671
      to_port     = 15671
      protocol    = "tcp"
      description = "Allow requests to RabbitMQ HTTP API with TLS"
      cidr_blocks = var.rabbitmq_cidr_blocks
    }, {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow console access"
      cidr_blocks = var.rabbitmq_cidr_blocks
    }
  ]
  egress_cidr_blocks = var.rabbitmq_egress_cidr_blocks
  egress_rules = ["all-all"]
}