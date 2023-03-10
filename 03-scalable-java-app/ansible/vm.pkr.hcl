variable "ami_id" {
  type    = string
  default = "ami-017fecd1353bcc96e"
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

  provisioner "ansible-local" {
  playbook_file = "playbook.yml"
  inventory_file = "inventory.ini"
  extra_arguments = [
    "-e",
    "efs_mount_point=<EFS_mount_point>",
    "-e",
    "jenkins_version=2.303.1",
  ]
}
}
