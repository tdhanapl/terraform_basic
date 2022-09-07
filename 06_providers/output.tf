## output of ec2 instance
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}
output "instance_ip_addr" {
  value = aws_instance.app_server.private_ip
}
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}