variable "ami_id" {
  type    = string
  default = "ami-0735c191cf914754d"
}

locals {
    app_name = "pet-clinic"
}

source "amazon-ebs" "nginx" {
  ami_name      = "PACKER-${local.app_name}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "${var.ami_id}"
  ssh_username  = "ubuntu"
  tags = {
    Env  = "DEMO"
    Name = "PACKER-${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.nginx"]

  provisioner "ansible" {
    playbook_file = "ami.yml"
    extra_vars = {
      consul_server_address = var.consul.server.ip
    }
  }

}
