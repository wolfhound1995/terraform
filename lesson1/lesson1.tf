#Lesson Create,Update,Destroy
provider "aws" {}


resource "aws_instance" "my_Ubuntu" {
  count         = 3
  ami           = "ami-04e601abe3e1a910f"
  instance_type = "t2.micro"
  tags = {
    Name    = "My Ubuntu server"
    Owner   = "Sviatoslav"
    Project = "terraform lessons"
  }
}


resource "aws_instance" "my_Amazon_linux" {
  ami           = "ami-0c4c4bd6cf0c5fe52"
  instance_type = "t2.small"
  tags = {
    Name    = "My Amazon server"
    Owner   = "Sviatoslav"
    Project = "terraform lessons"
  }
}

