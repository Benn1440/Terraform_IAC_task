output "public_subnet_acl_id" {
  value = aws_network_acl.Public_SubnetNACL.id
}

output "private_subnet_acl_id" {
  value = aws_network_acl.Private_SubnetNACL.id
}