#----------------------------------------------------------
# My Terraform
#
# Local Variables
#
# Made by Sviatoslav
#----------------------------------------------------------

provider "aws" {
  region = "ca-central-1"
}


data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  full_project_name = "${var.environment}-${var.project_name}"
  project_owner     = "${var.owner} owner of ${var.project_name}"
}


locals {
  country  = "Canada"
  city     = "Deadmonton"
  az_list  = join(",", data.aws_availability_zones.available.names)
  region   = data.aws_region.current.description
  location = "In ${local.region} there are AZ: ${local.az_list}"
}

resource "aws_eip" "my_static_ip" {
  vpc = true # Need to add in new AWS Provider version
  tags = {
    Name       = "Static IP"
    Owner      = var.owner
    Project    = local.full_project_name
    proj_owner = local.project_owner
    city       = local.city
    region_azs = local.az_list
    location   = local.location
  }
}
