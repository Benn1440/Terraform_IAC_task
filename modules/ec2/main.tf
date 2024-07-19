resource "aws_instance" "web-server" {
 ami           =   data.aws_ami.server_ami.id
 key_name = aws_key_pair.ec2-authentication.id
  //instance_type = "t2.micro"
  //availability_zone = "eu-west-1"
  count = var.instance_count

  user_data = file("userdata1.tpl")

   tags = {
    Name = var.instance_name
  }
}

resource "aws_instance" "Database-Instance" {
  count = var.instance_count
  ami           =   data.aws_ami.server_ami.id
   key_name = aws_key_pair.ec2-authentication.id
  //instance_type = "t2.micro"
  //availability_zone = "eu-west-1"

  user_data = file("userdata.tpl")

   tags = {
    Name = var.instance_name
  }
}