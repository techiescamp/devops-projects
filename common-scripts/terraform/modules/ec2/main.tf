resource "aws_security_group" "instance-sg" {
  name        = "instance-sg"
  description = "Security Group for Instance"

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
  vpc_security_group_ids = [aws_security_group.instance-sg.id]

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }

  subnet_id = element(var.subnet_ids, count.index % length(var.subnet_ids))
}
