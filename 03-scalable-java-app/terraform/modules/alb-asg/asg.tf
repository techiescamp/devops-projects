resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.environment}-${var.application}-instance_profile"

  role = aws_iam_role.iam_role.id
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "${var.environment}-${var.application}-instance-sg"

  ingress {
    from_port   = var.ingress_asg_cidr_from_port
    to_port     = var.ingress_asg_cidr_to_port
    protocol    = var.ingress_asg_cidr_protocol
    cidr_blocks = var.ingress_asg_cidr_blocks
  }

  ingress {
    from_port       = var.ingress_asg_sg_from_port
    to_port         = var.ingress_asg_sg_to_port
    protocol        = var.ingress_asg_sg_protocol
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = var.egress_asg_from_port
    to_port     = var.egress_asg_to_port
    protocol    = var.egress_asg_protocol
    cidr_blocks = var.egress_asg_cidr_blocks
  }

  tags = merge(
    {
      Name        = "${var.environment}-${var.application}-asg-sg"
      Environment = var.environment,
      Owner       = var.owner,
      CostCenter  = var.cost_center,
      Application = var.application
    },
    var.tags
  )
}


resource "aws_launch_template" "petclinic_lt" {
  name_prefix   = "${var.environment}-${var.application}-petclinic-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = "${var.environment}-${var.application}-instance_profile"
  }

  network_interfaces {
    associate_public_ip_address = var.public_access
    security_groups             = [aws_security_group.instance_sg.id]
  }

  user_data = base64encode(var.user_data)
}

locals {
  asg_tags = merge(
    var.tags,
    { "Name" = "${var.environment}-${var.application}-asg" }
  )
}

resource "aws_autoscaling_group" "petclinic" {
  name                = "${var.environment}-${var.application}-asg"
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.subnets

  launch_template {
    id      = aws_launch_template.petclinic_lt.id
    version = aws_launch_template.petclinic_lt.latest_version
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  dynamic "tag" {
    for_each = local.asg_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                      = "${var.environment}-${var.application}-cpu-scaling-policy"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = var.instance_warmup_time
  autoscaling_group_name    = aws_autoscaling_group.petclinic.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_value
  }
}

resource "aws_autoscaling_attachment" "petclinic" {
  autoscaling_group_name = aws_autoscaling_group.petclinic.name
  lb_target_group_arn    = aws_alb_target_group.petclinic.arn
}
