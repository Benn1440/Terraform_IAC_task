terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
  profile = "terraform_user"
}

module "aws_vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public-subnet-cidr  = "10.0.1.0/24"
  private-subnet-cidr = "10.0.2.0/24"
}

module "security_groups" {
  source = "./modules/sg"
  vpc_id = module.aws_vpc.KCVPC.id
  igw_id = module.aws_internet_gateway.kcvpc.id
}

resource "aws_key_pair" "ec2-authentication" {
  key_name   = "devopskey"
  public_key = file(" ~/.ssh/devopskey.pub")
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = "ami-12345678"
  subnet_id         = module.aws_vpc.public_subnet.id
  instance_type     = "t2.micro"
  security_group_id = module.security_groups.public_sg.id
  instance_name     = "Webserver"

}

module "ec2-instance" {
  source            = "./modules/ec2"
  ami_id            = "ami-12345678" # Replace with a valid AMI ID
  instance_type     = "t2.micro"
  subnet_id         = module.aws_vpc.private_subnet.id
  security_group_id = module.security_groups.private_sg.id
  instance_name     = "Database-Instance"
  
}

module "nacl" {
  source             = "./modules/nacl"
  vpc_id             = module.aws_vpc.KCVPC.id
  public_subnet_cidr = "10.0.1.0/24"
}
# module "security_groups" {
#   source = "./modules/security_groups"
#   vpc_id = module.vpc.vpc_id
#   your_ip = "your_local_ip/32"  # Replace with your local IP
# }



