data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "us-west-2a" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "availability-zone"
    values = ["us-west-2a"]
  }
}

resource "aws_security_group" "efs_sg" {
  name_prefix = "efs-sg"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_file_system" "jenkins" {
  creation_token = "jenkins"
  encrypted      = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  tags = {
    Name = "jenkins-efs"
  }
}

resource "aws_efs_mount_target" "jenkins" {
  file_system_id   = aws_efs_file_system.jenkins.id
  subnet_id        = data.aws_subnet.us-west-2a.id
  security_groups = [aws_security_group.efs_sg.id]
}
