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
    Name = var.tags 
  }
}
##command for creating##
# terraform init 
# terraform plan -var-file instance.tfvars
# terraform apply-var-file instance.tfvars
# terraform apply -var-file instance.tfvars --auto-approve
# terraform destroy -var-file instance.tfvars --auto-approve

