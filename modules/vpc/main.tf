# Create a VPC
resource "aws_vpc" "KCVPC" {
  cidr_block = var.vpc_cidr
}

# Creating a public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.KCVPC.id
  cidr_block = var.public-subnet-cidr.id
  //availability_zone = ["eu-west-1a"]
  //cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main public subnet"
  }
} 

# Creating a private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.KCVPC.id
  cidr_block = var.private-subnet-cidr.id
  //availability_zone = [ "eu-west-1b"]
}

# Creating Internet Gateway
resource "aws_internet_gateway" "kcvpc-igw" {
  vpc_id = aws_vpc.KCVPC.id

  tags = {
    Name = "vpc IG"
  }
}

# Creating Elastic IP for the Natgateway

resource "aws_eip" "natgateway-ip" {
  domain = "vpc"
}

# Define the security group for public instances
resource "aws_security_group" "public_sg" {
  name        = "public-security Group"
  description = "Security group for public instances (e.g., web servers)"
  vpc_id      = aws_vpc.KCVPC.id  

  # Inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //ipv6_cidr_blocks = ["::/0"]
    description = "Allow HTTP traffic from anywhere"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //ipv6_cidr_blocks = ["::/0"]
    description = "Allow HTTPS traffic from anywhere"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public-subnet-cidr.id  # Replace with your local IP
    description = "Allow SSH traffic from a specific IP"
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   // ipv6_cidr_blocks = ["::/0"]
    description = "Allow all outbound traffic"
  }
}

# Define the security group for private instances
resource "aws_security_group" "private_sg" {
  name        = "private-security Group"
  description = "Security group for private instances (e.g., database servers)"
  vpc_id      = aws_vpc.KCVPC.id 

  # Inbound rules (e.g., PostgreSQL port 5432)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.public_sg.id]
    description = "Allow PostgreSQL traffic from the public subnet"
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "Allow all outbound traffic"
  }
}

# Creating Public Route Table
resource "aws_route_table" "kcvpc-pubicRT" {
  vpc_id = aws_vpc.KCVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kcvpc-igw.id
  }

  tags = {
    Name = "Main"
  }
}


resource "aws_network_acl" "pubic-acl" {
  vpc_id = aws_vpc.KCVPC.id
  # subnet_ids = awsprivate-subnet-cidr.id

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
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "main"
  }
}

resource "aws_network_acl" "private-acl" {
  vpc_id = aws_vpc.KCVPC.id
  # subnet_ids = aws_subnet.public-subnet.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.public-subnet-cidr.id
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }
}

resource "aws_network_acl_rule" "private_ingress" {
  network_acl_id = aws_network_acl.private-acl.id
  egress         = false
  rule_number    = 200
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.public-subnet-cidr.id
  from_port      = 0
  to_port        = 65535
}

resource "aws_network_acl_rule" "private_egress" {
  network_acl_id = aws_network_acl.private-acl.id
  egress         = true
  rule_number    = 200
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}

resource "aws_network_acl_rule" "private_egress_public" {
  network_acl_id = aws_network_acl.private-acl.id
  egress         = true
  rule_number    = 201
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.public-subnet-cidr.id
  from_port      = 0
  to_port        = 65535
}

# Creating Nat Gateway in Public Subnet
resource "aws_nat_gateway" "kcvpc-ng" {
  allocation_id = aws_eip.natgateway-ip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.kcvpc-igw]
}

# Creating Private Route Table
resource "aws_route_table" "kcvpc-privateRT" {
  vpc_id = aws_vpc.KCVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.kcvpc-ng.id
  }

  tags = {
    Name = "Main"
  }
}

# Creating Public Route Table Association
resource "aws_route_table_association" "kcvpc-pubicRTA" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.kcvpc-privateRT.id
}

# Creating Private Route Table Association
resource "aws_route_table_association" "kcvpc-privateRTA" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.kcvpc-privateRT.id
}