#----------------------------------------------------------
# My Terraform
# Lesson with AWS Data Sources for Lookup AMIid
# Find Latest AMI id of:
#    - Ubuntu 18.04
#    - Amazon Linux 2
#    - Windows Server 2016 Base
#
# Made by Sviatoslav
#-----------------------------------------------------------


provider "aws" {
  region = "ap-southeast-2"
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


data "aws_ami" "latest_windows_2022" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }

}

// How to use
/*
resource "aws_instance" "my_webserver_with_latest_ubuntu_ami" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
}
*/


output "latest_windows_2022_ami_id" {
  value = data.aws_ami.latest_windows_2022.id
}

output "latest_windows_2022_ami_name" {
  value = data.aws_ami.latest_windows_2022.name
}


output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "latest_amazon_linux_ami_name" {
  value = data.aws_ami.latest_amazon_linux.name
}


output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}
