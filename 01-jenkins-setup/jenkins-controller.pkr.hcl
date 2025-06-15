variable "ami_id" {
  type    = string
  default = "ami-04b4f1a9cf54c11d0"
}

variable "efs_mount_point" {
  type    = string
  default = ""
}

locals {
  app_name = "jenkins-controller-updated"
}

source "amazon-ebs" "jenkins" {
  ami_name      = "${local.app_name}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  availability_zone = "us-west-2b"
  source_ami    = "${var.ami_id}"
  ssh_username  = "ubuntu"
  tags = {
    Env  = "dev"
    Name = "${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.jenkins"]

  provisioner "ansible" {
  playbook_file = "ansible/jenkins-controller.yaml"
  user          = "ubuntu"
  extra_arguments = [ "--extra-vars", "ami-id=${var.ami_id} efs_mount_point=${var.efs_mount_point}", "--scp-extra-args", "'-O'", "--ssh-extra-args", "-o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa" ]
  } 
  
  post-processor "manifest" {
    output = "manifest.json"
    strip_path = true
  }
}
