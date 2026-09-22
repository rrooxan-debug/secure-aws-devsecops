resource "aws_vpc" "secure_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "secure-devsecops-vpc"
    Project = "Secure AWS DevSecOps"
  }
}

resource "aws_subnet" "secure_public_subnet" {
  vpc_id                  = aws_vpc.secure_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "secure-public-subnet"
    Project = "Secure AWS DevSecOps"
  }
}

resource "aws_internet_gateway" "secure_igw" {
  vpc_id = aws_vpc.secure_vpc.id

  tags = {
    Name    = "secure-devsecops-igw"
    Project = "Secure AWS DevSecOps"
  }
}

resource "aws_route_table" "secure_public_rt" {
  vpc_id = aws_vpc.secure_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secure_igw.id
  }

  tags = {
    Name    = "secure-public-route-table"
    Project = "Secure AWS DevSecOps"
  }
}

resource "aws_route_table_association" "secure_public_subnet_assoc" {
  subnet_id      = aws_subnet.secure_public_subnet.id
  route_table_id = aws_route_table.secure_public_rt.id
}
