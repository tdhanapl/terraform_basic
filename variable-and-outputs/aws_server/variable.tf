variable "instance_type" {
	type = string
	description = "The size of the instance."
	#sensitive = true
	validation {
    condition     = can(regex("^t2.",var.instance_type))
    error_message = "The instance must be a t2 type EC2 instance."
	}
}