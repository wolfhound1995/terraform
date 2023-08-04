provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI, replace with your preferred AMI
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-terraform-bucket"
  acl    = "private"
}

resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.example_bucket.id
  key    = "index.html"
  source = "path/to/your/index.html"  # Update this to the actual path of your index.html file
}

provisioner "local-exec" {
  command = "aws s3 sync . s3://${aws_s3_bucket.example_bucket.id}"
}
