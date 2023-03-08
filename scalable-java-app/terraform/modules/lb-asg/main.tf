provider "aws" {
  region = var.region
}

resource "aws_security_group" "load_balancer_sg" {
  name        = "load_balancer_security_group"
  description = "Security group for the load balancer"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "loadbalancer-sg"
  }
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default_sub_west2a" {
  availability_zone = "us-west-2a"

  tags = {
    Name = "Default subnet for us-west-2a"
  }
}

resource "aws_default_subnet" "default_sub_west2b" {
  availability_zone = "us-west-2b"

  tags = {
    Name = "Default subnet for us-west-2b"
  }
}

resource "aws_lb" "loadbalancer" {
  name               = "petclinic-app-loadbalancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_sg.id]
  subnets = [
    "${aws_default_subnet.default_sub_west2a.id}",
    "${aws_default_subnet.default_sub_west2b.id}",
  ]

  tags = {
    Name = "application-loadbalancer"
  }
}

resource "aws_launch_template" "packer_pet_clinic" {
  name_prefix   = "packer-pet-clinic"
  image_id      = "ami-0de402856ac785a92"
  instance_type = "t2.micro"
}

resource "aws_lb_target_group" "target_group" {
  name        = "petclinic-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_default_vpc.default.id
  load_balancing_algorithm_type = "round_robin"
}

resource "aws_autoscaling_group" "autoscaling_group" {
  availability_zones = ["us-west-2a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  target_group_arns  = [aws_lb_target_group.ip-example.id]
  launch_template {
    id      = aws_launch_template.packer_pet_clinic.id
    version = "$Latest"
  }
}
