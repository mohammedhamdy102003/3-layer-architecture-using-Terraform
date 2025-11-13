resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "main_vpc"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id =  aws_vpc.main.id
    tags = {
        Name = "main_igw"
    }
}
resource "aws_subnet" "public-a" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet_a"
    }

}
resource "aws_subnet" "public-b" {
  vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
      Name="public_subnet_b"
    }
}
resource "aws_subnet" "private-a" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "private_subnet_a"
    }
}
resource "aws_subnet" "private-b" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "private_subnet_b"
    }
  
}
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public_route_table"
    }
  
}
# Associations
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

output "vpc_id" { value = aws_vpc.main.id }
output "public_subnets" { value = [aws_subnet.public_a.id, aws_subnet.public_b.id] }
output "private_subnets" { value = [aws_subnet.private_a.id, aws_subnet.private_b.id] }

