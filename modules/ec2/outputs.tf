output "instance_id" {
  # value = aws_instance.instance.id
  value = aws_instance.web-server.id
}

output "public_ip" {
  # value = aws_instance.instance.public_ip
  value = aws_instance.web-server.public_ip
}

# output "data" {
#   value = data.aws_ami.server_ami.id
# }