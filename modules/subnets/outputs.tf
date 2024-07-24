output "public_subnet_id" {
  # value = aws_subnet.public_Subnets.id
  value = aws_subnet.public_Subnet.id
}

output "private_subnet_id" {
  # value = aws_subnet.Private_Subnets.id
  value = aws_subnet.private_Subnet.id
}

output "public_subnet_cidr" {
  # value = aws_subnet.public_Subnets.cidr_block
  value = aws_subnet.public_Subnet.cidr_block
}