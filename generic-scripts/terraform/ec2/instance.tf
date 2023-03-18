provider "aws" {
  region = "us-west-2"
}

variable "instance_name" {
  type = string
  default = "live-test-instance"
}

variable "ami_id" {
  type = string
  default = "ami-0735c191cf914754d"
}

variable "instance_type" {
  type = string
  default = "t2.small"
}

variable "key_name" {
  type = string
  default = "techiescamp"
}

variable "security_group_ids" {
  type    = list(string)
  default = ["sg-01ce819e8d65269f0"]
}


resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = var.instance_name
  }

  subnet_id = data.aws_subnet.default.id

}

data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
  cidr_block = "172.31.32.0/20"
}


data "aws_vpc" "default" {
  default = true
} 


