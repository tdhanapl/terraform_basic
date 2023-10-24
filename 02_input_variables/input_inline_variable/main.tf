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
# terraform plan -var=vpc_name="dhana" -var=vpc_cidr_block="10.10.0.0/16"
# terraform apply -var=vpc_name="dhana" -var=vpc_cidr_block="10.10.0.0/16" --auto-approve
# terraform destroy -var=vpc_name="dhana" -var=vpc_cidr_block="10.10.0.0/16"  --auto-approve