terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}



######
provider "aws" {
  region     = "ap-south-1"
  #access_key = "access_key"
  #secret_key = "secret_key"
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
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdgyskPBKxTa4G8rIT76MP1zKfL4Xv9UBn/k/p7bEQYLPzhGQfdki3em2Hnh/wGzjeRJsRCCgezMnyirOizm3jXbob5F9QVBGbwn0cQMu1CW9Dx59ce+vJQtz9ezCAocko7W8oij3fr0npJWVQchxiR+yI5lm1PexaESYTTmz/ImzmeF2AJNRDqKR4xFrK9kM22GOm2kd7YYXIxpqDOMZ7j7v1HHU9v9CwgHCGbq0c09EshCXLx0GZ7r3BjRun8vQ9OxgVGIf62MQAUbMPKR0oq84X5oVv/2a4d79Bx46Ttj1xlzP8UHgWrUKHUbpFZ6AZEMMIsLOzoduLk8eCzNvPWH/SkaEoc2ww+7+Ii0fDyeycTHzewQtXxyyzNDyFrZj8b08c+Pg1h26PClMNajUF4eBO8+u4ZbcvsDMdXKimvYeRXXaFMciy6NcMCq0ZwtwvmLsId+pm9Gu1WS/QG3JmRYUSMzc1FPZG9DI2aI3ivG3HQEuYe25hhik6adw24lk= root@DESKTOP-J1KCQ03"
}
##creating the ec2-instance
resource "aws_instance" "my_server" {
  #for_each      = data.aws_subnet.public.ids
  ami           = var.ami_image_id.redhat ##varibale type = map
  instance_type = var.instance_type[0]
  key_name               = var.key_pair
  associate_public_ip_address  = true
  availability_zone            = var.availability_zone.AZ1
  #security_groups -- it for new security group while ec2_instance creating
  vpc_security_group_ids = [ var.security_groups_id ]
  #subnet_id = var.public_subnet_id
  subnet_id     = data.aws_subnet.selected.id
##provisioner file type
  provisioner "file" {
    content     = "mars"
    destination = "/home/ec2-user/barsoon.txt"
		connection {
			type     = "ssh"
			user     = "ec2-user"
			host     = self.public_ip
			private_key = file("/home/ec2-user/linux.pem")
		}
  }
  
  tags = {
    Name = var.tags
  }
}

##command for creating##
# terraform init 
# terraform plan 
# terraform apply
# terraform apply --auto-approve
# terraform destroy --auto-approve
#terraform apply -replace="aws_instance.test-terraform"
