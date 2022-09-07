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

#creating ec2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-06a0b4e3b7eb7a300"
  instance_type = var.instance_type

  tags = {
    Name = "my-server"
  }
}
##command for creating##
# terraform init 
# terraform plan 
# terraform apply
# terraform apply --auto-approve
# terraform destroy --auto-approve
#not clear pending
