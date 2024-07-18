terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
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
}

module "ec2" {
  source = "./modules/ec2"
}


module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  your_ip = "your_local_ip/32"  # Replace with your local IP
}

module "public_instance" {
  source = "./modules/ec2_instance"
  ami_id           = "ami-12345678"  # Replace with a valid AMI ID
  instance_type    = "t2.micro"
  subnet_id        = module.vpc.public_subnet_id
  security_group_id = module.security_groups.public_sg_id
  instance_name    = "PublicInstance"
}

module "private_instance" {
  source = "./modules/ec2_instance"
  ami_id           = "ami-12345678"  # Replace with a valid AMI ID
  instance_type    = "t2.micro"
  subnet_id        = module.vpc.private_subnet_id
  security_group_id = module.security_groups.private_sg_id
  instance_name    = "PrivateInstance"
}
