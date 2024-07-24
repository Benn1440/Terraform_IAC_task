# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.30"
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

# module "security_groups" {
#   source = "./modules/sg"
#   vpc_id = module.aws_vpc.KCVPC.id
#   igw_id = module.aws_internet_gateway.kcvpc.id
# }

# module "datasources" {
#   source = "/datasources"
# }

module "ec2" {
  source            = "./modules/ec2"
  # ami_id            = "ami-05842291b9a0bd79f"
  subnet_id         = module.aws_vpc.public_subnet.id
  instance_type     = "t2.micro"
  //security_group_id = module.security_groups.public_sg.id
  server_ami_id = data.aws_ami.server_ami.id
  instance_name     = "Webserver"
}


module "ec2-instance" {
  source            = "./modules/ec2"
  # ami_id            = "ami-05842291b9a0bd79f" # Replace with a valid AMI ID
  instance_type     = "t2.micro"
  subnet_id         = module.aws_vpc.private_subnet.id
  //security_group_id = module.security_groups.private_sg.id
  server_ami_id = data.aws_ami.server_ami.id
  instance_name     = "Database-Instance"
}


# module "nacl" {
#   source             = "./modules/nacl"
#   vpc_id             = module.aws_vpc.KCVPC.id
#   public_subnet_cidr = "10.0.1.0/24"
# }
# module "security_groups" {
#   source = "./modules/security_groups"
#   vpc_id = module.vpc.vpc_id
#   your_ip = "your_local_ip/32"  # Replace with your local IP
# }



