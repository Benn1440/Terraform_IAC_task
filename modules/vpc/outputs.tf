output "igw_id" {
  value = aws_internet_gateway.kcvpc-igw.id
}

output "aws_vpc" {
  value = aws_vpc.KCVPC.id
}
