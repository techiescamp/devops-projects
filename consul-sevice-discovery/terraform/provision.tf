provider "aws" {
  region = var.region
}

resource "aws_security_group" "consul_server_sg" {
  name        = "consul_server_security_group"
  description = "Security group for the consul server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65000
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "consul-server-sg"
  }
}

resource "aws_security_group" "load_balancer_sg" {
  name        = "load_balancer_security_group"
  description = "Security group for the load balancer"

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

resource "aws_security_group" "backends_sg" {
  name        = "backends_security_group"
  description = "Security group for the backends"

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
    Name = "backend-sg"
  }
}

resource "aws_instance" "consul_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.consul_server_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "consul-server"
  }
}

resource "aws_instance" "load_balancer" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.load_balancer_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "loadbalancer"
  }
}

resource "aws_instance" "backends" {
  count                  = 2
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.backends_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "backend-app"
  }
}
