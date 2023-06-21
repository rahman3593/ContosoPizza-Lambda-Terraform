
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

resource "aws_route_table" "igw-route-table" {
  vpc_id = var.vpc_id
  route {
    cidr_block =  "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "route_table_association" {
  count = length(var.public_subnets)
  subnet_id      = var.public_subnets[count.index]
  route_table_id = aws_route_table.igw-route-table.id
}