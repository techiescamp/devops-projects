variable "region" {
  type        = string
  description = "Region of the EC2 instance"
}

variable "volume-size" {
  type        = number
}

variable "ami_id" {
  type        = string
  description = "AMI ID of the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type of the EC2 instance"
}

variable "key_name" {
  type        = string
  description = "Key name of the EC2 instance"
}

variable "instance_count" {
  type        = number
  description = "Count of the EC2 instances"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs of the EC2 instance"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the security group"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the security group resources"
}

variable "name" {
  type        = string
  description = "The name of the resources"
}

variable "environment" {
  type        = string
  description = "The environment name for the resources"
}

variable "owner" {
  type        = string
  description = "Owner's name for the resource"
}

variable "cost_center" {
  type        = string
  description = "Cost center identifier for the resource"
}

variable "application" {
  type        = string
  description = "Name of the application related to the resource"
}


variable "ingress_cidr_from_port" {
  type        = list(number)
  description = "List of starting ports for cidr ingress rules of the EC2 security group."
}

variable "ingress_cidr_to_port" {
  type        = list(number)
  description = "List of ending ports for cidr ingress rules of the EC2 security group."
}

variable "ingress_cidr_protocol" {
  type        = list(string)
  description = "List of protocols for cidr ingress rules of the EC2 security group."
}

variable "ingress_cidr_description" {
  type        = list(string)
  description = "Description for this ingress rule"
}

variable "ingress_cidr_block" {
  type        = list(string)
  description = "List of CIDR blocks for cidr ingress rules of the EC2 security group."
}

variable "egress_cidr_from_port" {
  type        = list(number)
  description = "List of starting ports for cidr egress rules of the EC2 security group."
}

variable "egress_cidr_to_port" {
  type        = list(number)
  description = "List of ending ports for cidr egress rules of the EC2 security group."
}

variable "egress_cidr_protocol" {
  type        = list(any)
  description = "List of protocols for cidr egress rules of the EC2 security group."
}

variable "egress_cidr_block" {
  type        = list(string)
  description = "List of CIDR blocks for cidr egress rules of the EC2 security group."
}

variable "create_ingress_cidr" {
  type        = bool
  description = "Enable or disable CIDR block ingress rules."
}

variable "create_egress_cidr" {
  type        = bool
  description = "Enable or disable CIDR block egress rules."
}

