provider "aws" {
  region = "us-west-2"
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
    cidr_blocks = ["172.31.0.0/16"]
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

  tags = {
    Name = "backend-sg"
  }
}

resource "aws_instance" "consul_server" {
  ami           = "ami-0735c191cf914754d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.consul_server_sg.id]
  key_name = "techiescamp"

  tags = {
    Name = "consul-server"
  }
}

resource "aws_instance" "load_balancer" {
  ami           = "ami-0735c191cf914754d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backends_sg.id]
  key_name = "techiescamp"

  tags = {
    Name = "loadbalancer"
  }
}

resource "aws_instance" "backends" {
  count         = 2
  ami           = "ami-0735c191cf914754d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.load_balancer_sg.id]
  key_name = "techiescamp"

  tags = {
    Name = "backend-app"
  }
}
