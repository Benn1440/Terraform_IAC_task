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
    cidr_blocks = ["<your-local-ip>/32"]  # Replace with your local IP
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