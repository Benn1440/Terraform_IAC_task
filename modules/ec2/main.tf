# data "aws_ami" "server_ami" {
#   most_recent = true
#   owners = [ "099720109477" ]

#   filter {
#     name = "name"
#     values = [ "amazon/ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" ]
#   }
# }

resource "aws_key_pair" "ec2-authentication" {
  key_name   = "devopskey"
  public_key = file("~/.ssh/devopskey.pub")
}

resource "aws_instance" "web-server" {
  # ami           =   aws_ami.server_ami.id
  ami =       var.server_ami_id
  key_name = aws_key_pair.ec2-authentication.id
  instance_type = "t2.micro"
  //availability_zone = "eu-west-1"
  # count = var.instance_count

  user_data = file("userdata1.tpl")

   tags = {
    Name = var.instance_name
  }
}

resource "aws_instance" "Database-Instance" {
  #  count = var.server_ami_id.id
  #  ami = aws_ami.server_ami.id
  #  ami           =   data.aws_ami.server_ami
   ami =       var.server_ami_id
   key_name = aws_key_pair.ec2-authentication.id
   instance_type = "t2.micro"
  //availability_zone = "eu-west-1"

  user_data = file("userdata.tpl")
 
   tags = {
    Name = var.instance_name
  }
}