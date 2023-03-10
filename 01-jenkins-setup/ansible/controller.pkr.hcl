variable "ami_id" {
  type    = string
  default = "ami-0735c191cf914754d "
}

locals {
  app_name = "jenkins-controller"
}

source "amazon-ebs" "jenkins" {
  ami_name      = "${local.app_name}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "${var.ami_id}"
  ssh_username  = "ubuntu"
  tags = {
    Env  = "dev"
    Name = "${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.jenkins"]

  provisioner "ansible-local" {
  playbook_file = "jenkins.yaml"
  extra_arguments = [
    "-e",
    "efs_mount_point=<EFS_mount_point>",
    "-e",
    "jenkins_version=2.303.1",
  ]
}
}
