variable "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the EC2 instances."
}

variable "instance_type" {
  description = "The type of EC2 instance to use for the ASG."
}

variable "key_name" {
  description = "The name of the EC2 key pair to use for the instances."
}

variable "environment" {
  description = "The environment name for the resources."
}

variable "vpc_id" {
  description = "The ID of the VPC to use for the resources."
}

variable "subnets" {
  description = "A list of subnet IDs to use for the resources."
  type        = list(string)
}
