output "east_public_ip" {
  value = aws_instance.my_east_server.public_ip
}
output "west_public_ip" {
  value = aws_instance.my_west_server.public_ip
}