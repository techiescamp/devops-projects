resource "aws_security_group" "alb_sg" {
  name_prefix = "${var.environment}-${var.application}-alb-sg"

  ingress {
    from_port   = var.ingress_alb_from_port
    to_port     = var.ingress_alb_to_port
    protocol    = var.ingress_alb_protocol
    cidr_blocks = var.ingress_alb_cidr_blocks
  }

  egress {
    from_port   = var.egress_alb_from_port
    to_port     = var.egress_alb_to_port
    protocol    = var.egress_alb_protocol
    cidr_blocks = var.egress_alb_cidr_blocks
  }

  tags = merge(
    {
      Name        = "${var.environment}-${var.application}-alb-sg",
      Environment = var.environment,
      Owner       = var.owner,
      CostCenter  = var.cost_center,
      Application = var.application
    },
    var.tags
  )
}

resource "aws_alb" "application_load_balancer" {
  name               = "${var.environment}-${var.application}-alb"
  internal           = var.internal
  load_balancer_type = var.loadbalancer_type

  subnets         = var.subnets
  security_groups = [aws_security_group.alb_sg.id]

  tags = merge(
    {
      Name        = "${var.environment}-${var.application}-alb",
      Environment = var.environment,
      Owner       = var.owner,
      CostCenter  = var.cost_center,
      Application = var.application
    },
    var.tags
  )
}

resource "aws_alb_target_group" "petclinic" {
  name_prefix = "pc-alb"
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  load_balancing_algorithm_type = var.load_balancing_algorithm

  tags = merge(
    {
      Name        = "${var.environment}-${var.application}-alb-target-group"
      Environment = var.environment,
      Owner       = var.owner,
      CostCenter  = var.cost_center,
      Application = var.application
    },
    var.tags
  )
}

resource "aws_alb_listener" "application_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    target_group_arn = aws_alb_target_group.petclinic.arn
    type             = var.listener_type
  }
}