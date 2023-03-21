resource "aws_security_group" "jenkins-agent" {
  name        = "jenkins-agent"
  description = "Allow SSH inbound traffic from everywhere and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
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


resource "aws_instance" "example" {
  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins-agent.id]

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }

  subnet_id = element(var.subnet_ids, count.index % length(var.subnet_ids))
}
