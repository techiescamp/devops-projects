# EC2 Instance Variables
region         = "us-west-2"
ami_id         = "ami-03fd0aa14bd102718"
instance_type  = "t4g.micro"
key_name       = "techiescamp"
instance_count = 1
volume-size = 20

# VPC id
vpc_id  = "vpc-0a5ca4a92c2e10163"
subnet_ids     = ["subnet-058a7514ba8adbb07"]

# Ec2 Tags
name        = "prometheus-stack"
owner       = "techiescamp"
environment = "dev"
cost_center = "techiescamp-commerce"
application = "monitoring"

# CIDR Ingress Variables
create_ingress_cidr        = true
ingress_cidr_from_port     = [22, 80, 443, 9090, 9100, 9093, 3000]  # List of from ports
ingress_cidr_to_port       = [22, 80, 443, 9090, 9100, 9093, 3000]  # List of to ports
ingress_cidr_protocol      = ["tcp", "tcp", "tcp", "tcp", "tcp", "tcp", "tcp"]        # Protocol for all rules (you can add more if needed)
ingress_cidr_block         = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
ingress_cidr_description   = ["SSH", "HTTP", "HTTPS", "Prometheus", "Node-exporter", "Alert manager", "Grafana"]

# CIDR Egress Variables
create_egress_cidr    = true
egress_cidr_from_port = [0]
egress_cidr_to_port   = [0]
egress_cidr_protocol  = ["-1"]
egress_cidr_block     = ["0.0.0.0/0"]

