#vpc
resource "aws_vpc" "tst-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = "tes-vpc"
  }
}

#subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.tst-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.availability-zone-1a
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.tst-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.availability-zone-1b
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  vpc_id                  = aws_vpc.tst-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = var.availability-zone-1c
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-subnet-3"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.tst-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability-zone-1a

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.tst-vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = var.availability-zone-1b

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.tst-vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = var.availability-zone-1c

  tags = {
    Name = "private-subnet-3"
  }
}


#internet-gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tst-vpc.id

  tags = {
    Name = "tst-igw"
  }
}


#route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.tst-vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.tst-vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "private-route-table"
  }
}

#route table association
resource "aws_route_table_association" "public-rt-asc-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-rt-asc-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-rt-asc-3" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-rt-asc-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-rt-asc-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-rt-asc-3" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}

