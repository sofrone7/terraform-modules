# Security Group for NLB
resource "aws_security_group" "rabbitmq_nlb_sg" {
  name_prefix = "${var.rabbitmq_broker_name}-nlb"
  vpc_id      = var.rabbitmq_vpc_id

  ingress {
    from_port   = 5671
    to_port     = 5671
    protocol    = "tcp"
    cidr_blocks = [var.rabbitmq_nlb_ingress_with_cidr_blocks]
    description = "Connection with RabbitMQ"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Network Load Balancer
resource "aws_lb" "rabbitmq_nlb" {
  name               = "${var.rabbitmq_broker_name}-nlb"
  internal           = var.rabbitmq_publicly_accessible == false ? true : false
  load_balancer_type = "network"
  subnets            = var.rabbitmq_subnets_nlb

  enable_deletion_protection = true
}

# Target Group
resource "aws_lb_target_group" "rabbitmq_tg" {
  name        = "${local.project}-${local.environment}-5671-nlb-to-rabbitmq"
  port        = 5671
  protocol    = "TLS"
  vpc_id      = var.rabbitmq_vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "TCP"
    port                = "traffic-port"
  }
}

# Target Group Attachments
resource "aws_lb_target_group_attachment" "rabbitmq_targets" {
  count            = length(data.dns_a_record_set.mq_private_ips.addrs)
  target_group_arn = aws_lb_target_group.rabbitmq_tg.arn
  target_id        = data.dns_a_record_set.mq_private_ips.addrs[count.index]
  port             = 5671
}

# NLB Listener
resource "aws_lb_listener" "rabbitmq_listener" {
  load_balancer_arn = aws_lb.rabbitmq_nlb.arn
  port              = "5671"
  protocol          = "TLS"
  certificate_arn   = var.rabbitmq_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rabbitmq_tg.arn
  }
}

# Route53 Records
resource "aws_route53_record" "rabbitmq_dns" {
  count   = 3
  zone_id = var.rabbitmq_hosted_zone_id
  name    = var.rabbitmq_dns_record_name
  type    = "A"
  ttl     = 300

  set_identifier = "rabbitmq-${count.index + 1}"
  
  weighted_routing_policy {
    weight = var.rabbitmq_deployment_mode == "SINGLE_INSTANCE" ? (count.index == 0 ? 100 : 0) : 50
  }

  alias {
    name                   = aws_lb.rabbitmq_nlb.dns_name
    zone_id                = aws_lb.rabbitmq_nlb.zone_id
    evaluate_target_health = true
  }
}