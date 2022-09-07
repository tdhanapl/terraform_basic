
#provider name and region 
provider "aws" {
  region     = "ap-south-1"
  #access_key = "AKIA4PNPSPCJFINHAHVO"
  #secret_key = "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"
}
data "template_file" "user_data" {
  template = file("../userdata.yaml")
} 
data "aws_subnet_ids" "public_subnet_id" {
  vpc_id = var.vpc_id

  tags = {
    Tier = "public"
  }
}

resource "aws_instance" "app" {
  for_each      = data.aws_subnet_ids.public_subnet_id.ids
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = each.value
}

##creating the ec2-instance
resource "aws_instance" "test-terraform" {
  #count = 2 it will create two ec2-instance
  ami           = var.ami_image_id.redhat
  instance_type = var.instance_type[0]
  key_name               = var.key_pair
  associate_public_ip_address  = true
  availability_zone            = var.availability_zone.AZ1
  #instance_state               = "running"
  vpc_security_group_ids = [ "sg-04e6c7ee02cef7364" ]
  #security_groups =  vpc-a-security-group
  subnet_id = var.public_subnet_id
  #user_data = data.template_file.user_data.rendered
  tags = {
    Name = var.tags
  }
}

