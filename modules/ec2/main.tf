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

resource "aws_instance" "Database-Instance" {
  count = var.instance_count
 // ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID
  //instance_type = "t2.micro"
  //availability_zone = "eu-west-1"

  user_data = <<-EOF
      #!/bin/bash
      # Update the package index
      sudo apt-get update -y
      # Install PostgreSQL
      sudo apt-get install postgresql postgresql-contrib -y
      # Enable and start the PostgreSQL service
      sudo systemctl enable postgresql
      sudo systemctl start postgresql
    EOF

   tags = {
    Name = var.instance_name
  }
}