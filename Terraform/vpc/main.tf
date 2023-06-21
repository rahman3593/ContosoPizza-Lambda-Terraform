resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.${1 + count.index}.0/24"
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.${4 + count.index}.0/24"
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = "false"
}

resource "aws_subnet" "db_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.${7 + count.index}.0/24"
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = "false"
}