resource "aws_network_acl" "Public_SubnetNACL" {
  vpc_id = var.vpc_id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "102.88.33.239/32"
    from_port  = 443
    to_port    = 443
  }

  tags = {
    Name = "Public-Subnet-Network-ACL"
  }
}

resource "aws_network_acl" "Private_SubnetNACL" {
  vpc_id = var.vpc_id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.public_subnet_cidr
    from_port  = 5432 
    to_port    = 5432 
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.public_subnet_cidr
    from_port  = 5432 
    to_port    = 5432 
  }

  tags = {
    Name = "Private-Subnet-Network-ACL"
  }
}

resource "aws_network_acl_association" "Private_NACL_Association" {
  network_acl_id = aws_network_acl.Private_SubnetNACL.id
  subnet_id      = var.private_subnet_id
}