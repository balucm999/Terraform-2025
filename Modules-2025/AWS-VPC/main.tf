resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = var.name
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-igw"
  }
}
resource "aws_subnet" "public" {
  count = length(var.public_subnets)  
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}
resource "aws_subnet" "private" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = var.availability_zones[count.index]
    tags = {
      Name = "${var.name}-private-${count.index}"
    }  
}
resource "aws_eip" "nat_eip" {
  domain   = "vpc"
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.name}-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "${var.name}-public_routetable"
  }
}
resource "aws_route_table_association" "a" {
  count = length(var.public_subnets)  
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id      
}
  tags = {
    Name = "${var.name}-private_routetable"
  }
}
resource "aws_route_table_association" "b" {
  count = length(var.private_subnets)  
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}