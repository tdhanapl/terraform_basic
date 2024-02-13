##Prerequisites terraform
To follow this tutorial you will need:
1. The Terraform CLI (1.2.0+) installed.
2. The AWS CLI installed.
3. AWS account and associated credentials that allow you to create resources.

##good content  url
https://medium.com/appgambit/provisioning-a-jenkins-server-on-aws-with-terraform-bf04a6a6ef7f
https://medium.com/@awsyadav/automating-ecs-ec2-type-deployments-with-terraform-569863c60e69

##Installation of terraform in linux of rhel/centos
$ sudo yum install -y yum-utils
$ sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
$ sudo yum -y install terraform

##Installed the AWS CLI.
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$ unzip awscliv2.zip
$ ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
#set environment variable
$ vim /etc/profile.d/aws.sh
#!/bin/bash
export PATH=$PATH:/usr/local/bin/
:wq!
$ bash
$ aws --version

##AWS account and associated credentials that allow you to create resources.
#To create your access key ID and secret access key
1.Open the IAM console at https://console.aws.amazon.com/iam/.
2. On the navigation menu, choose Users.
3.Choose your IAM user name (not the check box).
4.Open the Security credentials tab, and then choose Create access key.
5.To see the new access key, choose Show. Your credentials resemble the following:
6.Access key ID: AKIAIOSFODNN7EXAMPLE
7.Secret access key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
8.To download the key pair, choose Download .csv file. Store the .csv file with keys in a secure location.

##Write configuration
The set of files used to describe infrastructure in Terraform is known as a Terraform configuration. You will write your first configuration to define a single AWS EC2 instance.
Each Terraform configuration must be in its own working directory. 
Create a directory for your configuration.
$ mkdir learn-terraform-aws-instance
$ cd learn-terraform-aws-instance
$ touch main.tf

#Open main.tf in your text editor, paste in the configuration below, and save the file.
$ vim main.tf
provider "aws" {
  region     = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
#resource "<provider>_<resource_type>" "name" {
Note:-Hard-coded credentials are not recommended in any Terraform configuration and risks secret leakage should this file ever be committed to a public version control system.

##Adding AWS credentials
# aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EdsdskXAMPLE 
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDEhdNG/bPxRfiCYEXAMPLEKEY
Default region name [None]: ap-south-1
Default output format [None]:
    or
## set credentials in the .aws configuration files
  
[root@ansible .aws]# vim credentials
[default]
aws_access_key_id =  AKIAIOSFODNNee7EXAMPLE 
aws_secret_access_key = wJalrXUtneeFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

:wq!
[root@ansible .aws]# vim  config
[default]
region = ap-south-1

:wq!

##Strings and Templates
##url for references of string and templates
https://www.terraform.io/language/expressions/strings

### variable types
1.string 
variable "ami_id" {
  type        =  string
  default     = "ami-06a0b4e3b7eb7a300"
}
#call string type varible in main.tf file
instance_type = var.ami_id#varibale type string

#2.list
variable "instance_type" {
  description = "ec2 instance_type"
  type        = list
  default     = ["t2.micro","t2.small","t2.medium"]
}
#call list type varible in main.tf file
instance_type = var.instance_type[0] #varibale type list

#3.map
variable "ami_image_id" {
  type        = map
  default     = {
    redhat = "ami-06a0b4e3b7eb7a300"
    amazon = "ami-079b5e5b3971bd10d"
	  ubuntu = "ami-068257025f72f470d"
  }
}

#call map type varible  in main.tf file
instance_type = var.ami_image_id.redhat #varibale type = map

##Terraform visualing exexution plan
#Install graphviz.x86_64 package
This guide let you learn how to install graphviz.x86_64 package:
$ sudo dnf makecache
$ sudo dnf install graphviz.x86_64

#Uninstall / Remove graphviz.x86_64 package
Please follow the step by step instructions below to uninstall graphviz.x86_64 package:
$ sudo dnf remove graphviz.x86_64
$ sudo dnf autoremove

##To create the terraform plan graphviz
$ terraform graph -Tsvg > graph.svg

##Initialize the project.
$ terraform init

##Show changes required by the current configuration
$ terraform plan

##Check whether the configuration is valid
Format your configuration. Terraform will print out the names of the files it modified, if any. In this case, your configuration file was already formatted correctly, so Terraform wont return any file names.
$ terraform fmt

##Check whether the configuration is valid
$ terraform validate
Success! The configuration is valid.

##Create or update infrastructure
Apply the configuration now with the terraform apply command. Terraform will print output similar to what is shown below. We have truncated some of the output to save space.
$ terraform apply

##Create or update infrastructure with auto-approve 
#If we use "--auto-approve" it will not ask for yes or no prompt
$ terraform apply --auto-approve 
##Show output values from your root module
syntax:-
$ terraform [global options] output [options] [NAME]
options:-

  -state=path      Path to the state file to read. Defaults to
                   "terraform.tfstate".

  -no-color        If specified, output wont contain any color.

  -json            If specified, machine readable output will be
                   printed in JSON format.

  -raw             For value types that can be automatically
                   converted to a string, will print the raw
                   string directly, rather than a human-oriented
                   representation of the value.

$ terraform output

##print specific  resource output with below command
$ terraform output <name>
$ terraform output vpc_idl

##Update the terraform state file  to match remote systems
$ terraform  apply refresh --> refresh module deprecated need to refresh-only
Note:
-->terraform refresh will not modify your real objects, but it will modfiy the terraform state.
--> terraform refresh has been deprectated and with the refresh-only because it was not safe since it did not give you an opportunity to review propesed changes before updating state file.

$ terraform  apply -refresh-only
Note:
--> terraform will notic that vm you provisioned is missing 
--> With the refresh-only flag that the missing VM is intentional 
--> terraform will propose to delete the VM from the state file. the state file is wrong changes the state file to macth infrastruture.

## Show the current state or a saved plan
Inspect the current state using terraform show.
$ terraform show

## To chheck Workspace  management
$ terraform workspace list

## To check the current terraform state file of source create in aws 
$ terraform state list
aws_iam_user.user_name[0]
aws_iam_user.user_name[1]
aws_iam_user.user_name[2]
aws_vpc.VPC-A

## To destroy the specific target soruce in terraform state file 
$ terraform destroy -target aws_iam_user.user_name[2]

## How to do changes in the configuration of already created resources using terraform 
 For that we can use one command called terraform import 
 $ terraform import <resource_type>.<resource_name> [unique_id_from_aws]
  
##If you lose the terraform state file 
The process of recovering a deleted state file is never easy. You should import all the resources with terraform import

##If you have 20 resource  in that we want to delete particular resource
$ terraform destroy -target aws_iam_user.user_name[2]

##Key pair generating in terraform coded
#First we need generate the public key using ssh-keygen
$ ssh-keygen
$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9pXjkBHlAHEI62Y/3hqXSeSYelfPFL7mZg+296hZgG5LNVnP2DKfouA8wy3tX21RsaYJcPHNlwGSSv2QJVZoxtPdJbyDDxMagWkxuBr3HbXfvq43C9f/mR7ZOSRijVGUbOTb+oRR7xyZ9RI7+ohdDoQUOPYVLd+l0L/0WdHe4j/zCA4cetabq5LFEt8+nxDQ6Nm3kLscUK7N0y5BLiJYUjVroGAq/i+oBSTpxRum6DWF1xC4+1cFrO0ihvq+Q+R3C0y/OVe97/nUxXexftgkFIgZQ9A4sX/5f93nQPKqv+/BaVzbwAFhVrDEdz4ih/OL7XVoS8UsXRHiU51/rjFF0RtwDChcjow32SS0UgmbQhyx6Fd1ai7qF8iXtQXvHIxDrxScHj1XRhM6KeIfUGci6Xx8WEzoFVtGqp7XzAtHwSjNWu4fYZXJ+V+Z/f/bpEvOgtvT0Z1D1J8QtTHTTyoXNJiySv2j2SOS2M1K5D7w2z8svUGti3jzsURmE1T/SvPk= root@ansible.cntech.local
It will create the public and private key 
#Now in terraform  write code  for key pair
resoure "aws_key_pair" "terraform" {
  key_name = "terraform-key"
  public_key = <"here we need to add that public key">
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9pXjkBHlAHEI62Y/3hqXSeSYelfPFL7mZg+296hZgG5LNVnP2DKfouA8wy3tX21RsaYJcPHNlwGSSv2QJVZoxtPdJbyDDxMagWkxuBr3HbXfvq43C9f/mR7ZOSRijVGUbOTb+oRR7xyZ9RI7+ohdDoQUOPYVLd+l0L/0WdHe4j/zCA4cetabq5LFEt8+nxDQ6Nm3kLscUK7N0y5BLiJYUjVroGAq/i+oBSTpxRum6DWF1xC4+1cFrO0ihvq+Q+R3C0y/OVe97/nUxXexftgkFIgZQ9A4sX/5f93nQPKqv+/BaVzbwAFhVrDEdz4ih/OL7XVoS8UsXRHiU51/rjFF0RtwDChcjow32SS0UgmbQhyx6Fd1ai7qF8iXtQXvHIxDrxScHj1XRhM6KeIfUGci6Xx8WEzoFVtGqp7XzAtHwSjNWu4fYZXJ+V+Z/f/bpEvOgtvT0Z1D1J8QtTHTTyoXNJiySv2j2SOS2M1K5D7w2z8svUGti3jzsURmE1T/SvPk= root@ansible.cntech.local"
}
##Environment variables
$ Terraform loads variables in the following order, with later sources taking precedence over earlier ones:
1.Environment variables
2.The terraform.tfvars file, if present.
3.The terraform.tfvars.json file, if present.
4.Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
5.Any -var and -var-file options on the command line, in the order they are provided.
 (This includes variables set by a Terraform Cloud workspace.)

##Input inline varible means call varible while runing the terraform command
#In varible  file 
variable "vpc_name" {
  description = "vpc_name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "vpc_cidr_block_ip"
  type        = string
}

$ terraform plan -var=vpc_name="dhana" -var=vpc_cidr_block="10.10.0.0/16"
##depends-on
#depends-on means it will create s3 create first and next ec2-instance will create.
resource "aws_s3_bucket" "bucket" {
  bucket = "43802482094298-depends-on"
}
resource "aws_instance" "my_server" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
	depends_on = [
		aws_s3_bucket.bucket  
	]
}
###provisioners
 By default, provisioners that fail will also cause the Terraform apply itself to fail. To  change the fail
#The on_failure setting can be used to change this.
The allowed values are:
1.continue: Ignore the error and continue with creation or destruction.
2.fial: Raise an error and stop applying (the default behavior). If this is a creation provisioner, taint the resource.
// Example
resource "aws_instance" "web" {
# ...
  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
    on_failure = "continue"
  }
}

## define destroy provisioner and give an example?
You can define destroy provisioner with the parameter when
provisioner "remote-exec" {
when = "destroy"
}

##terraform cloud login
#first generate the token in terraform cloud 
$ terraform login
	here paste the terraform token
# New to TFC? Follow these steps to instantly apply an example configuration:
$ git clone https://github.com/hashicorp/tfc-getting-started.git
$ cd tfc-getting-started
$ scripts/setup.sh

####Terraform questions##########
1. when you excute the terraform init it getting error ""plugin out-of-date, provider unable to sync?
$ terraform init -upgrade  it update new-releases
2. When you are doing initialization with terraform init, you want to skip backend initialization. What should you do?
$ terraform init -backend=false
3. When you are doing initialization with terraform init, you want to skip child module installation. What should you do?
$ terraform init -get=false
4. When you are doing initialization with terraform init, you want to skip plugin installation. What should you do?
$ terraform init -get-plugins=false
5.How do you preview the behavior of the command terraform destroy?
$ terraform plan -destroy
6. How do you save the execution plan?
$ terraform plan -out=tfplan
you can use that file with apply
terraform apply tfplan
7. How do you target only specific resources when you run a terraform plan?
-target=resource - A Resource Address to target. This flag can be
used multiple times. See below for more information.
8. How do you update the state prior to checking differences when you run a terraform plan?
terraform plan -refresh=true
9.Can you disable state locking?
Yes. You can disable state locking for most commands with the -lock flag but it is not recommended.
10. When installing the modules and where does the terraform save these modules?
.terraform/modules
// Example
.terraform/modules
├── ec2_instances
│ └── terraform-aws-modules-terraform-aws-ec2-instance-ed6dcd9
├── modules.json
└── vpc
└── terraform-aws-modules-terraform-aws-vpc-2417f60
11. How do you rename a resource in the terraform state file and  remove items from the Terraform state?
terraform state mv 'packet_device.worker' 'packet_device.helper'
terraform state rm 'packet_device.worker'
The terraform state rm command is used to remove items from the Terraform state. This command can remove single resources, single instances of a resource, entire modules, and more.

12. What is the command to pull the remote state?
terraform state pull
This command will download the state from its current location and output the raw format to stdout.

13. What is the command is used manually to upload a local state file to a remote state
terraform state push
EX:
terraform state push [options] PATH
14. When you are using workspaces where does the Terraform save the state file for the local state?
terraform.tfstate.d
For local state, Terraform stores the workspace states in a directory called terraform.tfstate.d.
15. What is the command usage?
terraform state <subcommand> [options] [args]
16. You are working on terraform files and you want to list all the resources. What is the command you should use?
terraform state list
17. How do you list the resources for the given name?
terraform state list <resource name>
18. What is the command that shows the attributes of a single resource in the state file?
terraform state show 'resource name'
19. What is the command to list the workspaces?
terraform workspace list
20. What is the command to create a new workspace?
terraform workspace new <name>
21. What is the command to show the current workspace?
terraform workspace show
22. What is the command to switch the workspace?
terraform workspace select <workspace name>
23. What is the command to delete the workspace?
terraform workspace delete <workspace name>
24. Can you delete the default workspace?
No. You can not ever delete default workspace.
25. You are working on the different workspaces and you want to use a different number of instances based on the workspace. How do you achieve that?
$ resource "aws_instance" "example" {
count = "${terraform.workspace == "default" ? 5 : 1}"
# ... other arguments
}

26. You are working on the different workspaces and you want to use tags based on the workspace. How do you achieve that?
resource "aws_instance" "example" {
  tags = {
    Name = "web - ${terraform.workspace}"
  }
# ... other arguments
}
27. You are formatting the configuration files and what is the flag you should use to see the differences?
terraform fmt -diff
28. You are formatting the configuration files and what is the flag you should use to
process the subdirectories as well?
terraform fmt -recursive
29. You are formatting configuration files in a lot of directories and you don’t want
to see the list of file changes. What is the flag that you should use?
terraform fmt -list=false
30. What is the command taint?
The terraform taint command manually marks a Terraform-managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
This command will not modify infrastructure, but does modify the state file in order to mark a resource as tainted. 
Once a resource is marked as tainted, the next plan will show that the resource will be destroyed and recreated and the next apply will implement this change.
