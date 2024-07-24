
resource "aws_key_pair" "ec2-authentication" {
  key_name   = "devopskey"
  public_key = file("~/.ssh/devopskey.pub")
}

resource "aws_instance" "web-server" {
  ami           = "ami-05842291b9a0bd79f" #Available on AWS Public AMIs
  # ami =       var.server_ami_id
  key_name = aws_key_pair.ec2-authentication.id
  instance_type = "t3.micro"
  subnet_id = var.public_subnet_id
  security_groups = [ var.public_security_group_id ]
  associate_public_ip_address = true
  

  user_data = file("userdata1.tpl")

   tags = {
    Name = "Webserver-Instance"
  }
}

resource "aws_instance" "Database-Instance" {
   ami           = "ami-05842291b9a0bd79f" #Available on AWS Public AMIs
  #  ami =       var.server_ami_id
   key_name = aws_key_pair.ec2-authentication.id
   instance_type = "t3.micro"
   subnet_id = var.private_subnet_id
   secondary_private_ips = [ var.public_security_group_id ]
  //availability_zone = "eu-west-1"
   associate_public_ip_address = false

  user_data = file("userdata.tpl")
 
   tags = {
    Name = "Database-Instance"
  }
}


# module "ec2" {
#   source            = "./modules/ec2"
#   # ami_id            = "ami-05842291b9a0bd79f"
#   subnet_id         = module.aws_vpc.public_subnet.id
#   instance_type     = "t2.micro"
#   //security_group_id = module.security_groups.public_sg.id
#   server_ami_id = data.aws_ami.server_ami.id
#   instance_name     = "Webserver"
# }


# module "ec2-instance" {
#   source            = "./modules/ec2"
#   # ami_id            = "ami-05842291b9a0bd79f" # Replace with a valid AMI ID
#   instance_type     = "t2.micro"
#   subnet_id         = module.aws_vpc.private_subnet.id
#   //security_group_id = module.security_groups.private_sg.id
#   server_ami_id = data.aws_ami.server_ami.id
#   instance_name     = "Database-Instance"
# }