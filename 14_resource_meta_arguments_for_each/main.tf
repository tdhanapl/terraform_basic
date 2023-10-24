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
resource "aws_instance" "my_server" {
	for_each = {
		nano = "t2.nano"
		micro =  "t2.micro"
		small =  "t2.small"
	}
  ami           = var.ami_image_id.redhat #varibale type = map
  instance_type = each.value
  key_name               = var.key_pair
  associate_public_ip_address  = true
  availability_zone            = var.availability_zone.AZ1
  #instance_state               = "running"
  #security_groups -- it for new security group while ec2_instance creating
  vpc_security_group_ids = [ var.security_groups_id ]
  #subnet_id = var.public_subnet_id
  subnet_id     = data.aws_subnet.selected.id
  
	tags = {
		Name = "Server-${each.key}"
	}
}
##command for creating##
# terraform init 
# terraform plan 
# terraform apply
# terraform apply --auto-approve
# terraform destroy --auto-approve

