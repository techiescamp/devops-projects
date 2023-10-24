#Network
region  = "us-west-2"
vpc_id  = "vpc-0a5ca4a92c2e10163"
subnets = ["subnet-058a7514ba8adbb07", "subnet-032f5077729435858", "subnet-0dbcd1ac168414927"]

#alb_sg
ingress_alb_from_port   = 80
ingress_alb_to_port     = 80
ingress_alb_protocol    = "tcp"
ingress_alb_cidr_blocks = ["0.0.0.0/0"]
egress_alb_from_port    = 0
egress_alb_to_port      = 0
egress_alb_protocol     = "-1"
egress_alb_cidr_blocks  = ["0.0.0.0/0"]

#alb
internal          = false
loadbalancer_type = "application"

#target_group
target_group_port                = 8080
target_group_protocol            = "HTTP"
target_type                      = "instance"
load_balancing_algorithm         = "round_robin"
health_check_path                = "/"
health_check_port                = 8080
health_check_protocol            = "HTTP"
health_check_interval            = 30
health_check_timeout             = 5
health_check_healthy_threshold   = 2
health_check_unhealthy_threshold = 2

#instance_sg
ingress_asg_cidr_from_port = 22
ingress_asg_cidr_to_port   = 22
ingress_asg_cidr_protocol  = "tcp"
ingress_asg_cidr_blocks    = ["0.0.0.0/0"]
ingress_asg_sg_from_port   = 8080
ingress_asg_sg_to_port     = 8080
ingress_asg_sg_protocol    = "tcp"
egress_asg_from_port       = 0
egress_asg_to_port         = 0
egress_asg_protocol        = "-1"
egress_asg_cidr_blocks     = ["0.0.0.0/0"]

#asg
max_size         = 3
min_size         = 1
desired_capacity = 2

#listener
listener_port     = 80
listener_protocol = "HTTP"
listener_type     = "forward"

#launch_template
ami_id               = "ami-0f7a74cccd5a223bc"
instance_type        = "t2.medium"
key_name             = "techiescamp"
user_data            = <<-EOF
#!/bin/bash
bash /home/ubuntu/start.sh
EOF
public_access        = true
instance_warmup_time = 30
target_value         = 50

owner       = "techiescamp"
environment = "dev"
cost_center = "techiescamp-commerce"
application = "pet-clinic"