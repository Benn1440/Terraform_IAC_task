resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "public-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "A" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "B" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "C" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "105.112.204.227/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "D" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "D" {
  security_group_id = aws_security_group.private_sg.id
  cidr_ipv4         = var.public_subnet_cidr
  from_port         = 5432 # database port for PostgreSQL
  ip_protocol       = "tcp"
  to_port           = 5432 
}

resource "aws_vpc_security_group_egress_rule" "B" {
  security_group_id = aws_security_group.private_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}