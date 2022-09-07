#creating vpc, internet_gateway, route table, subnet, associate the subnet to route table and security_group
#provider
provider "aws" {
  region     = "ap-south-1"
  #access_key = "AKIA4PNPSPCJFINHAHVO"
  #secret_key = "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"
}
#1.creating the vpc with main name
resource "aws_vpc" "VPC-A" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames    = true
  tags = {
    Name =  "prod-${var.vpc_name}"
  }
}
