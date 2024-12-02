resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "eks-route-table"
  }
}

resource "aws_route_table_association" "a" {
  count          = 2
  subnet_id      = element(aws_subnet.main_subnet[*].id, count.index)
  route_table_id = aws_route_table.main.id
}
