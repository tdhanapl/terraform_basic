variable "vpc_name" {
  description = "vpc_name"
  type        = string
  #default     = "VPC-A"
}
variable "name" {
  description = "vpc_name"
  type        = list
  default     = ["A","B","C"]
}
variable "vpc_cidr_block" {
  description = "vpc_cidr_block_ip"
  type        = string
## Limits Terraform UI output when the variable is used in configuration.
  sentive = true
  #default     = "10.50.0.0/16"
}
