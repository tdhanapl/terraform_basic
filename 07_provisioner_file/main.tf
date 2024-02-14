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
##creating the ec2-instance
resource "aws_instance" "test-terraform" {
  #for_each      = data.aws_subnet.public.ids
  ami           = var.ami_image_id.redhat
  instance_type = var.instance_type[0]
  key_name               = var.key_pair
  associate_public_ip_address  = true
  availability_zone            = var.availability_zone.AZ1
  #instance_state               = "running"
  #security_groups -- it for new security group while ec2_instance creating
  vpc_security_group_ids = [ var.security_groups_id ]
  #subnet_id = var.public_subnet_id
  subnet_id     = data.aws_subnet.selected.id
  #tenancy = tenancy

  ## generic remote provisioners (i.e. file/remote-exec)
  provisioner "file" {
  content     = "I am creating a file"
  destination = "/home/ec2-user/store.txt"

  connection {
    type     = "ssh"
    user     = "ec2-user"
    #password = var.root_password
    host     = self.public_ip
    private_key = file("/home/ec2-user/linux.pem")
  }
}

  tags = {
    Name = var.tags
  }
}

#terraform apply -replace="aws_instance.test-terraform"
#terraform apply -refresh=false
##command for creating##
# terraform init 
# terraform plan 
# terraform apply
# terraform apply --auto-approve
# terraform destroy --auto-approve
