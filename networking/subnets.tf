data "aws_availability_zones" "available" {
  # names attribute removed as it is not configurable
}

resource "aws_subnet" "main_subnet" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "eks-subnet-${count.index}"
  }
}

output "subnet_ids" {
  value = aws_subnet.main_subnet[*].id
}
