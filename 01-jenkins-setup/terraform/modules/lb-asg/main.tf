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
    Name = "jenkins-alb-sg"
  }
}

resource "aws_lb" "jenkins" {
  name               = "jenkins-alb"
  internal           = false
  load_balancer_type = "application"

  subnets            = var.subnets
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "jenkins-controller-sg"

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
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-controller-sg"
  }
}


resource "aws_lb_target_group" "jenkins" {
  name_prefix      = "jks-lb"
  port             = 8080
  protocol         = "HTTP"
  vpc_id           = var.vpc_id
  target_type      = "instance"

  health_check {
    path                = "/login"
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

resource "aws_lb_listener" "jenkins" {
  load_balancer_arn = aws_lb.jenkins.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.jenkins.arn
    type             = "forward"
  }
}

resource "aws_launch_template" "jenkins" {
  name_prefix = "jenkins-controller-lt"
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.instance_sg.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "jenkins" {
  name                 = "jenkins-controller-asg"
  max_size             = 1
  min_size             = 1
  desired_capacity    = 1
  vpc_zone_identifier = var.subnets
  launch_template {
    id = aws_launch_template.jenkins.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "jenkins-controller"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_attachment" "jenkins" {
  autoscaling_group_name = aws_autoscaling_group.jenkins.name
  lb_target_group_arn    = aws_lb_target_group.jenkins.arn
}



