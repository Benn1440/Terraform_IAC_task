# output "aws_ami" {
#   value = data.aws_ami.server_ami.id
# }

# output "server_ami_id" {
#   value = data.aws_ami.server_ami.id
# }

output "vpc_id" {
  value = module.aws_vpc.vpc_id
}

output "public_subnet_id" {
  value = module.subnet.public_subnet_id
}

output "private_subnet_id" {
  value = module.subnet.private_subnet_id
}

output "igw_id" {
  value = module.internet_gateway.igw_id
}

output "public_route_table_id" {
  value = module.route_table.public_route_table_id
}

output "private_route_table_id" {
  value = module.route_table.private_route_table_id
}

output "nat_gateway_id" {
  value = module.nat_gateway.nat_gateway_id
}

output "public_security_group_id" {
  value = module.security_group.public_security_group_id
}

output "private_security_group_id" {
  value = module.security_group.private_security_group_id
}

output "public_subnet_acl_id" {
  value = module.network_acl.public_subnet_acl_id
}

output "private_subnet_acl_id" {
  value = module.network_acl.private_subnet_acl_id
}

output "public_instance_id" {
  value = module.ec2_instance.public_instance_id
}

output "private_instance_id" {
  value = module.ec2_instance.private_instance_id
}
