output "public_route_table_id" {
  value = aws_route_table.Public_RouteTable.id
}

output "private_route_table_id" {
  value = aws_route_table.Private_RouteTable.id
}