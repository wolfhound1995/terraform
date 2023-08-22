#Lesson with AWS Data Sources

provider "aws" {}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}
data "aws_vpc" "prod_vpc" {
  tags = {
    Name = "prod"
  }
}


resource "aws_subnet" "prod_subnet_1" {
  vpc_id            = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "172.31.1.0/24"
  tags = {
    Name    = "Subnet-1 in ${data.aws_availability_zones.available.names[0]}"
    Account = "subnet-1 in ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}

resource "aws_subnet" "prod_subnet_2" {
  vpc_id            = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "172.31.2.0/24"
  tags = {
    Name    = "Subnet-2 in ${data.aws_availability_zones.available.names[1]}"
    Account = "subnet-2 in ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}



output "vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "vpc_cidr" {
  value = data.aws_vpc.prod_vpc.cidr_block
}


output "aws_region" {
  value = data.aws_region.current.name
}

output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}

output "aws_region_desc" {
  value = data.aws_region.current.description
}


output "data_aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
