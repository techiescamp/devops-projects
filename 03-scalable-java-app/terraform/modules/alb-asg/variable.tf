variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the resources"
}

variable "ingress_alb_from_port" {
  type        = number
  description = "Ingress alb from port"
}

variable "ingress_alb_to_port" {
  type        = number
  description = "Ingress alb to port"
}

variable "ingress_alb_protocol" {
  type        = string
  description = "Ingress alb protocol"
}

variable "ingress_alb_cidr_blocks" {
  type        = list(string)
  description = "List of starting ports for cidr ingress rules of the security group."
}

variable "egress_alb_from_port" {
  type        = number
  description = "egress alb from port"
}

variable "egress_alb_to_port" {
  type        = number
  description = "egress alb to port"
}

variable "egress_alb_protocol" {
  type        = string
  description = "egress alb protocol"
}

variable "egress_alb_cidr_blocks" {
  type        = list(string)
  description = "List of starting ports for cidr egress rules of the security group."
}

variable "internal" {
  description = "Whether the load balancer is internal or not"
  type        = bool
}

variable "loadbalancer_type" {
  description = "Load balancer type"
  type        = string
}

variable "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the EC2 instances."
}

variable "instance_type" {
  description = "The type of EC2 instance to use for the ASG."
}

variable "key_name" {
  description = "The name of the EC2 key pair to use for the instances."
}

variable "vpc_id" {
  description = "The ID of the VPC to use for the resources."
}

variable "subnets" {
  description = "A list of subnet IDs to use for the resources."
  type        = list(string)
}

variable "target_group_port" {
  description = "Target group port"
  type        = number
}

variable "target_group_protocol" {
  description = "Target group protocol"
  type        = string
}

variable "target_type" {
  description = "Target type"
  type        = string
}

variable "load_balancing_algorithm" {
  description = "Specify the load balancing algorithm type"
  type        = string
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
}

variable "health_check_port" {
  description = "Health check port"
  type        = number
}

variable "health_check_protocol" {
  description = "Health check protocol"
  type        = string
}

variable "health_check_interval" {
  description = "Health check interval"
  type        = number
}

variable "health_check_timeout" {
  description = "Health check timeout"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "Health check healthy threshold"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "Health check unhealthy threshold"
  type        = number
}

variable "ingress_asg_cidr_from_port" {
  type        = number
  description = "Ingress asg from port"
}

variable "ingress_asg_cidr_to_port" {
  type        = number
  description = "Ingress asg to port"
}

variable "ingress_asg_cidr_protocol" {
  type        = string
  description = "Ingress asg protocol"
}

variable "ingress_asg_cidr_blocks" {
  type        = list(string)
  description = "List of starting ports for cidr ingress rules of the security group."
}

variable "ingress_asg_sg_from_port" {
  type        = number
  description = "Ingress asg from port"
}

variable "ingress_asg_sg_to_port" {
  type        = number
  description = "Ingress asg to port"
}

variable "ingress_asg_sg_protocol" {
  type        = string
  description = "Ingress asg protocol"
}

variable "egress_asg_from_port" {
  type        = number
  description = "egress asg from port"
}

variable "egress_asg_to_port" {
  type        = number
  description = "egress asg to port"
}

variable "egress_asg_protocol" {
  type        = string
  description = "egress asg protocol"
}

variable "egress_asg_cidr_blocks" {
  type        = list(string)
  description = "List of starting ports for sg egress rules of the security group."
}

variable "public_access" {
  description = "Whether the instance is public or not"
  type        = bool
}

variable "max_size" {
  description = "Maximum size of something"
  type        = number
}

variable "min_size" {
  description = "Minimum size of something"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of something"
  type        = number
}

variable "listener_port" {
  description = "Listener port"
  type        = number
}

variable "listener_protocol" {
  description = "Listener protocol"
  type        = string
}

variable "user_data" {
  description = "user data script"
  type        = string
}

variable "listener_type" {
  description = "Listener type"
  type        = string
}

variable "instance_warmup_time" {
  description = "Time required to warm up a new instance"
  type        = number
}

variable "target_value" {
  description = "Threshold value of asg to start scaling"
  type        = number
}

variable "environment" {
  type        = string
  description = "The environment name for the resources."
}

variable "owner" {
  type        = string
  description = "Name of the owner"
}

variable "application" {
  type        = string
  description = "Name of the application"
}

variable "cost_center" {
  type        = string
  description = "Name of cost-center"
}