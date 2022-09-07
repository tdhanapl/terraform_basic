##output chaining using module or sub-module
terraform {
}

module "aws_server" {
	source = ".//aws_server"
	instance_type = "t2.micro"
}

output "public_ip" {
  value = module.aws_server.public_ip
}
########command for creating##
# terraform init 
# terraform plan 
# terraform apply
# terraform apply --auto-approve
# terraform output -json 
# terraform output -json | jq -r .
# terraform output -json | jq -r ".public_ip.type"
# terraform output -json | jq -r ".public_ip.value"
# terraform destroy --auto-approve
