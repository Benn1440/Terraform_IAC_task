output "public_subnet_id" {
  value = aws_subnet.public_Subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.Private_Subnet.id
}

output "public_subnet_cidr" {
  value = aws_subnet.public_Subnet.cidr_block
}