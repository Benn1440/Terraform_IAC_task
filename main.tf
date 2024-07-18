terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      //version = "~> 5.0"
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

module "ec2" {
  source = "./modules/ec2"
}

