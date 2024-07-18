resource "aws_instance" "web-server" {
 // ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID
  //instance_type = "t2.micro"
  //availability_zone = "eu-west-1"
  count = var.instance_count

  user_data = <<-EOF
    #!/bin/bash
    # Update the package repository
    sudo yum update -y

    # Install Nginx
    sudo amazon-linux-extras install nginx1 -y

    # Start Nginx service
    sudo systemctl start nginx

    # Enable Nginx to start on boot
    sudo systemctl enable nginx
  EOF

   tags = {
    Name = var.instance_name
  }
}

#########################
resource "aws_instance" "instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = var.instance_name
  }
}
#####################
resource "aws_instance" "Database-Instance" {
  count = var.instance_count
 // ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID
  //instance_type = "t2.micro"
  //availability_zone = "eu-west-1"

  user_data = <<-EOF
    #!/bin/bash
    # Update the package repository
    sudo yum update -y

    # Install Nginx
    sudo amazon-linux-extras install nginx1 -y

    # Start Nginx service
    sudo systemctl start nginx

    # Enable Nginx to start on boot
    sudo systemctl enable nginx
  EOF

   tags = {
    Name = var.instance_name
  }
}