variable "environment" {}

variable "rabbitmq_broker_name" {
  type        = string
  description = "Name of the broker"
}

variable "rabbitmq_engine_version" {
  type        = string
  description = "Version of the broker engine"
}

variable "rabbitmq_host_instance_type" {
  type        = string
  description = "Broker's instance type"
}

variable "rabbitmq_deployment_mode" {
  type        = string
  description = "Deployment mode of the broker"
}

variable "rabbitmq_username" {
  type        = string
  description = "Username of the user"
}

variable "project" {
  type        = string
  description = "Name of project"
}

variable "rabbitmq_security_groups" {
  type        = list(string)
  default     = []
  description = "List of security group IDs assigned to the broker"
}

variable "rabbitmq_apply_immediately" {
  type        = bool
  description = "Specifies whether any broker modifications are applied immediately, or during the next maintenance window"
}

variable "rabbitmq_auto_minor_version_upgrade" {
  type        = bool
  description = "Whether to automatically upgrade to new minor versions of brokers as Amazon MQ makes releases availablecription"
}

variable "rabbitmq_publicly_accessible" {
  type        = bool
  description = "Whether to enable connections from applications outside of the VPC that hosts the broker's subnets"
}

variable "rabbitmq_authentication_strategy" {
  type        = string
  description = "Authentication strategy used to secure the broker"
}

variable "rabbitmq_ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of IPv4 CIDR ranges to use on all default RabbitMQ ingress rules"
}

variable "rabbitmq_egress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of IPv4 CIDR ranges to use on all default RabbitMQ egress rules"
}

variable "rabbitmq_cidr_blocks" {
  type    = string
  default = "0.0.0.0/0"
}

variable "rabbitmq_broker_extra_tags" {
  default     = {}
  description = "A mapping of extra tags to assign to the resource"
}

variable "rabbitmq_dns_record_name" {
  type        = string
  description = "DNS record name for RabbitMQ"
}

variable "rabbitmq_subnets_nlb" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the NLB that will allow applications to use a static custom domain endpoint for RabbitMQ"
}

variable "rabbitmq_tg_health_check_ip_filter" {
  type        = list(string)
  description = "List of IPv4 CIDR ranges that allow NLB target group health check queries"
}

variable "rabbitmq_nlb_ingress_with_cidr_blocks" {
  type        = string
  description = "List of the ingress rules for the NLB Security Group"
}

variable "rabbitmq_day_of_week" {
  type = string
  description = "The day of the week for maintenance"
}

variable "rabbitmq_time_of_day" {
  type = string
  description = "The time for maintenance"
}
variable "rabbitmq_time_zone"  {
  type = string
  description = "The time zone for maintenance"  
}

variable "rabbitmq_project" {
  type        = string
  description = "Project name for RabbitMQ"
}

variable "rabbitmq_environment" {
  type        = string
  description = "Environment for RabbitMQ"
}

variable "rabbitmq_vpc_id" {
  type        = string
  description = "VPC ID where RabbitMQ is deployed"
}

variable "rabbitmq_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for single instance or multi-AZ cluster deployment mode"
}

variable "rabbitmq_use_aws_owned_key" {
  type        = bool
  default     = true
  description = "Whether to use an AWS owned key for encryption"
}

variable "rabbitmq_kms_key_id" {
  type        = string
  default     = ""
  description = "KMS key ID for encryption"
}

variable "rabbitmq_certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate for RabbitMQ NLB"
}

variable "rabbitmq_hosted_zone_id" {
  type        = string
  description = "Route53 hosted zone ID for RabbitMQ DNS records"
}