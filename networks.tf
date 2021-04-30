resource "aws_vpc" "x3iibits-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    "Name" = "x3iibits-vpc"
  }
}

resource "aws_subnet" "x3iibits-subnet-public-1" {
  vpc_id                  = aws_vpc.x3iibits-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "x3iibits-subnet-public-1"
  }
}

resource "aws_internet_gateway" "x3iibits-igw" {
  vpc_id = aws_vpc.x3iibits-vpc.id

  tags = {
    "Name" = "x3iibits-igw"
  }
}

resource "aws_route_table" "x3iibits-public-crt" {
  vpc_id = aws_vpc.x3iibits-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.x3iibits-igw.id
  }

  tags = {
    Name = "x3iibits-public-crt"
  }
}

resource "aws_route_table_association" "x3iibits-crta-public-subnet-1" {
  subnet_id      = aws_subnet.x3iibits-subnet-public-1.id
  route_table_id = aws_route_table.x3iibits-public-crt.id
}

resource "aws_security_group" "x3iibits-all" {
  vpc_id = aws_vpc.x3iibits-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "x3iibits-all"
  }
}

