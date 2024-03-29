#count=2 --it will create 2  number ec2-instance
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.58.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1" 
}
##data source of aws_subnet
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["Public-Subnet-A"]
  }
}
## data source of security group
data "aws_security_groups" "test" {
  filter {
    name   = "tag:Name"
    values = ["VPC-A-security-group"]
  }
  
}
##creating the ec2-instance
resource "aws_instance" "test-terraform" {
  count = 2 #It will create 2 instance
  ami           = var.ami_image_id.redhat
  instance_type = var.instance_type[0] #varibale type list
  key_name               = var.key_pair
  associate_public_ip_address  = true
  availability_zone            = var.availability_zone.AZ1
  #instance_state               = "running"
  #security_groups -- it for new security group while ec2_instance creating
  vpc_security_group_ids = [ var.security_groups_id ]
  #subnet_id = var.public_subnet_id
  subnet_id     = data.aws_subnet.selected.id
  #tenancy = tenancy
  tags = {
    Name = var.tags-"${count.index}"
  }
}
##command for creating##
# terraform init 
# terraform plan 
# terraform apply
# terraform apply --auto-approve
# terraform destroy --auto-approve



