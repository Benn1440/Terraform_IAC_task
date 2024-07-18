# Create a VPC
resource "aws_vpc" "KCVPC" {
  cidr_block = var.vpc_cidr
}

# Creating a public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.KCVPC.id
  cidr_block = var.public-subnet-cidr
  availability_zone = ["eu-west-1a"]
  //cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main public subnet"
  }
} 

# Creating a private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.KCVPC.id
  cidr_block = var.private-subnet-cidr
  availability_zone = [ "eu-west-1b"]
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
  route_table_id = aws_route_table.kcvpc-pubicRT.id
}

# Creating Private Route Table Association
resource "aws_route_table_association" "kcvpc-privateRTA" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.kcvpc-privateRT.id
}