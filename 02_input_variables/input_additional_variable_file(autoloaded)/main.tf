terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

#creating the vpc with main name
resource "aws_vpc" "VPC-A" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames    = true
  tags = {
    Name =  "prod-${var.vpc_name}"
  }
}
##command for creating##
# terraform init 
# terraform plan 
# terraform apply
# terraform apply --auto-approve
# terraform destroy --auto-approve