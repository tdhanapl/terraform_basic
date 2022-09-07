#creating vpc, internet_gateway, route table, subnet, associate the subnet to route table and security_group
#provider
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA4PNPSPCJFINHAHVO"
  secret_key = "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"
}
#1.creating the vpc 
resource "aws_vpc" "VPC-A" {
  cidr_block       = "10.50.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames    = true
  tags = {
    Name = "VPC-A"
  }
}
#2.create internet gateway, elastic ip and nat_gateway_id
resource "aws_internet_gateway" "VPC-A-IGW" {
  vpc_id = aws_vpc.VPC-A.id

  tags = {
    Name = "VPC-A-IGW"
  }
}
##create elastic_ip
resource "aws_eip" "elastic_ip" {
  vpc = true 
tags = {
  Name = "elastic_ip"
 }
}
##create the nat_gateway_id
resource "aws_nat_gateway" "VPC-A-NAT-GW" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.Private-Subnet-A.id

  tags = {
    Name = "Nat_gateway"
  }
}
#3.create the route table
#creating the public_route_table and adding route table of internet_gateway
resource "aws_route_table" "Public-RT" {
  vpc_id = aws_vpc.VPC-A.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC-A-IGW.id
  }

  tags = {
    Name = "Public-RT"
  }
}

##creating the private_route_table and adding route table of nat_gateway
resource "aws_route_table" "Private-RT" {
  vpc_id = aws_vpc.VPC-A.id
#here we are leave default route add if you add nat means 
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.VPC-A-NAT-GW.id
  }

  tags = {
    Name = "Private-RT"
  }
}
#4.create a subnets
#creating the public_subnet
resource "aws_subnet" "Public-Subnet-A" {
  vpc_id     = aws_vpc.VPC-A.id
  cidr_block = var.public_subnet_cidr_block
  #cidr_block              = "${var.Public_Subnet_1}"
  availability_zone       = var.public_subnet_availability_zone
  #map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-A"
  }
}
#creating the private_subnet
resource "aws_subnet" "Private-Subnet-A" {
  vpc_id     = aws_vpc.VPC-A.id
  cidr_block = var.private_subnet_cidr_block
  #cidr_block              = "${var.Public_Subnet_1}"
  availability_zone       = var.private_subnet_availability_zone
  #map_public_ip_on_launch = true
  tags = {
    Name = "Private-Subnet-A"
  }
}

#5. Associate the subnets with route tables
#Associate the public_subnets with public_route_table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.Public-Subnet-A.id
  route_table_id = aws_route_table.Public-RT.id
}

#Associate the private_subnets with private_route_table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.Private-Subnet-A.id
  route_table_id = aws_route_table.Private-RT.id
}
#6.create the security group
resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.VPC-A.id

  ingress {
    description      = "https port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description      = "ssh port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "vpc-a-security-group"
  }
}
