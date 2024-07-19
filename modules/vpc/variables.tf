variable "vpc_cidr" {
  description = "AWS CIDR block for KCVPC"
  type = string
}

variable "public-subnet-cidr" {
  type = string

}

variable "private-subnet-cidr" {
  type = string
}

