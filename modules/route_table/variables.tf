variable "vpc_id" {
  description = "Virtual Private Cloud"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway"
  type        = string
}

variable "nat_gateway_id" {
  description = "NAT Gateway"
  type        = string
}

variable "public_subnet_id" {
  description = "public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "private subnet"
  type        = string
}