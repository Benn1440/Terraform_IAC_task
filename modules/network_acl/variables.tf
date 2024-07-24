variable "vpc_id" {
  description = "Virtual Private Cloud  ID"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
}

variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
}