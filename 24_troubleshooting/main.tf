terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.58.0"
    }
  }


provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}
resource "aws_instance" "my_server" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
	tags = {
		Name = "MyServer"
	}
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}
####command for creating####
# terraform init 
# terraform plan
##To debug the error 
#TF_LOG=TRACE  terraform apply
#it will create a log for finding errors
#TF_LOG=TRACE TF_LOG_PATH=./terraform.log terraform apply
# terraform apply
# terraform apply --auto-approve
# terraform output
# terraform destroy --auto-approve

