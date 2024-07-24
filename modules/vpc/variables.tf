variable "vpc_cidr" {
  description = "AWS CIDR block for KCVPC"
  #type = string
}

variable "public-subnet-cidr" {
   description = "CIDR block for the public subnet"
  # type        = string
}

# variable "aws_subnet" {
  # type = string
# }

variable "private-subnet-cidr" {
  description = "CIDR block for the private subnet"
  # type        = string
}

# variable "vpc_id" {
#   description = "The ID of the VPC"
#   type        = string
# }

# variable "public_subnet_cidr" {
#   description = "CIDR block for the public subnet"
#   type        = string
# }

# variable "private_subnet_cidr" {
#   description = "CIDR block for the private subnet"
#   type        = string
# }

# variable "availability_zone" {
#   description = "Availability zone for the subnets"
#   type        = string
# }

# variable "name" {
#   description = "Name prefix for the resources"
#   type        = string
# }

# variable "vpc_id" {
#     type = string
# }


# variable "vpc_id" {
#    type = string
#   #  value = aws_vpc.KCVPC.id
# }
# variable "igw_id" {
#   type = string
# }