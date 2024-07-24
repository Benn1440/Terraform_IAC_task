resource "aws_route_table" "Public_RouteTable" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.Public_RouteTable.id
}

resource "aws_route_table" "Private_RouteTable" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.Private_RouteTable.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.Private_RouteTable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}