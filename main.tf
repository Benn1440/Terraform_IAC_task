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


# module "aws_vpc" {
#   source = "./modules/vpc"

#   vpc_cidr            = "10.0.0.0/16"
#   public-subnet-cidr  = "10.0.1.0/24"
#   private-subnet-cidr = "10.0.2.0/24"

# }

# module "datasources" {
#   source = "/datasources"
# }


module "aws_vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/subnet"
  vpc_id = module.aws_vpc.vpc_id
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  # vpc_id = module.vpc.vpc_id
  vpc_id = module.aws_vpc.vpc_id
}

module "nat_gateway" {
  source = "./modules/nat_gateway"
  public_subnet_id = module.subnet.public_subnet_id
}

module "route_table" {
  source = "./modules/route_table"
  vpc_id = module.aws_vpc.vpc_id
  igw_id = module.internet_gateway.igw_id
  nat_gateway_id = module.nat_gateway.nat_gateway_id
  public_subnet_id = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.aws_vpc.vpc_id
  public_subnet_cidr = module.subnet.public_subnet_cidr
}

module "network_acl" {
  source = "./modules/network_acl"
  vpc_id = module.aws_vpc.vpc_id
  public_subnet_cidr = module.subnet.public_subnet_cidr
  private_subnet_id = module.subnet.private_subnet_id
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  public_subnet_id = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
  public_security_group_id = module.security_group.public_security_group_id
  private_security_group_id = module.security_group.private_security_group_id
  ssh_key_name = var.ssh_key_name
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
# module "security_groups" {
#   source = "./modules/sg"
#   vpc_id = module.aws_vpc.KCVPC.id
#   igw_id = module.aws_internet_gateway.kcvpc.id
# }


