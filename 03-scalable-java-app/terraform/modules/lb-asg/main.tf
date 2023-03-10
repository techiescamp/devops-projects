resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-sg"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "petclinic-alb-sg"
  }
}

resource "aws_lb" "petclinic" {
  name               = "petclinic-alb"
  internal           = false
  load_balancer_type = "application"

  subnets            = var.subnets
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }

  enable_deletion_protection = true
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "instance-sg"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "petclinic-instance-sg"
  }
}


resource "aws_lb_target_group" "petclinic" {
  name_prefix      = "pc-lb"
  port             = 8080
  protocol         = "HTTP"
  vpc_id           = var.vpc_id
  target_type      = "instance"

  health_check {
    path                = "/health"
    port                = 8080
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_autoscaling_group" "petclinic" {
  name                 = "petclinic-asg"
  max_size             = 3
  min_size             = 1
  desired_capacity      = 2
  vpc_zone_identifier  = var.subnets
  launch_configuration = aws_launch_configuration.petclinic.id

  tag {
    key                 = "Name"
    value               = "petclinic-app"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "petclinic" {
  name_prefix            = "petclinic-lc"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  security_groups        = [aws_security_group.instance_sg.id]
  key_name               = var.key_name
  user_data              = filebase64("${path.module}/scripts/user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "petclinic" {
  autoscaling_group_name = aws_autoscaling_group.petclinic.name
  alb_target_group_arn   = aws_lb_target_group.petclinic.arn
}
