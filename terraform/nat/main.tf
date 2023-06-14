resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet_id
}

resource "aws_route_table" "nat-route-table" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "${var.name}-nat-route-table"
  }
}


resource "aws_route_table_association" "route_table_association" {
  count = length(var.private_subnets)
  subnet_id      = var.private_subnets[count.index]
  route_table_id = aws_route_table.nat-route-table.id
}