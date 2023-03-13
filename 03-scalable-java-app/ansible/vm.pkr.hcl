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
  }

  provisioner "file" {
    source = "file/spring-petclinic.jar"
    destination = "/home/ubuntu/spring-petclinic.jar"
  }

  provisioner "file" {
    source = "file/application.properties"
    destination = "/home/ubuntu/application.properties"
  }

  provisioner "file" {
    source = "file/secret.py"
    destination = "/home/ubuntu/secret.py"
  }

}
