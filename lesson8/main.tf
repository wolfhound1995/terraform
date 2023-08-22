#-----------------------------------------------------------------
# My terraform
#
# Build webserver during bootstrap
# Lesson with Dependencies depends_on
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

  tags = {
    Name  = "Web"
    Owner = "Sviatoslav"
  }
  depends_on = [aws_instance.my_db, aws_instance.my_app]
}

resource "aws_instance" "my_app" {
  ami                    = "ami-0c4c4bd6cf0c5fe52" #Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name  = "APP"
    Owner = "Sviatoslav"
  }
  depends_on = [aws_instance.my_db]

}

resource "aws_instance" "my_db" {
  ami                    = "ami-0c4c4bd6cf0c5fe52" #Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name  = "DB"
    Owner = "Sviatoslav"
  }

}


resource "aws_security_group" "my_webserver" {
  name        = "Dynamic SecurityGroup"
  description = "Dynamic SecurityGroup"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "1541", "9092", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Sviatoslav"
  }
}
