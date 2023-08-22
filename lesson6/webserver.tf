#-----------------------------------------------------------------
# My terraform
#
# Build webserver during bootstrap
# Lesson with LifeCycle and EIP
# Made by Sviatoslav
#-----------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id


resource "aws_instance" "my_webserver" {
  ami                    = "ami-0c4c4bd6cf0c5fe52" #Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Slavik",
    l_name = "Pavlov",
    names  = ["Vasya", "Kolya", "Petya", "Mary"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Sviatoslav"
  }

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Sviatoslav"
  }
}
