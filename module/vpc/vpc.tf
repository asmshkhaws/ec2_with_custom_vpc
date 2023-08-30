# Private subnet components is commented out


data "aws_availability_zones" "available" {
  state = "available"
}

# MAIN VPC
resource "aws_vpc" "asim_vpc" {
  cidr_block       = var.asim_vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.ENVIRONMENT}-asim-vpc"
  }
}

# PUBLIC SUBNET 01
resource "aws_subnet" "asim_vpc_public_subnet_01" {
  vpc_id     = aws_vpc.asim_vpc.id
  cidr_block = var.asim_public_subnet01_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.ENVIRONMENT}-asim-vpc-public-subnet01"
  }
}

# PUBLIC SUBNET 02
resource "aws_subnet" "asim_vpc_public_subnet_02" {
  vpc_id     = aws_vpc.asim_vpc.id
  cidr_block = var.asim_public_subnet02_cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.ENVIRONMENT}-asim-vpc-public-subnet02"
  }
}

# PRIVATE SUBNET 01
# resource "aws_subnet" "asim_vpc_private_subnet_01" {
#   vpc_id     = aws_vpc.asim_vpc.id
#   cidr_block = var.asim_private_subnet01_cidr_block
#    availability_zone = data.aws_availability_zones.available.names[0]
#   tags = {
#     Name = "${var.ENVIRONMENT}-asim-vpc-private-subnet01"
#   }
# }

# PRIVATE SUBNET 02
# resource "aws_subnet" "asim_vpc_private_subnet_02" {
#   vpc_id     = aws_vpc.asim_vpc.id
#   cidr_block = var.asim_private_subnet02_cidr_block
#   availability_zone = data.aws_availability_zones.available.names[1]
#   tags = {
#     Name = "${var.ENVIRONMENT}-asim-vpc-private-subnet01"
#   }
# }

# INTERNET GATEWAY
resource "aws_internet_gateway" "asim-igw" {
  vpc_id = aws_vpc.asim_vpc.id
  tags = {
    Name = "${var.ENVIRONMENT}-asim-internet-gateway"
  }
}

# ELASTIC IP FOR NAT GATEWAY
# resource "aws_eip" "asim_nat_eip" {
#   vpc      = true
#   depends_on = [aws_internet_gateway.asim-igw]
# }

# NATGATEWAY FOR PRIVATE SUBNET
# resource "aws_nat_gateway" "asim-vpc-ngw" {
#   allocation_id = aws_eip.asim_nat_eip.id
#   subnet_id     = aws_subnet.asim_vpc_public_subnet_01.id
#   tags = {
#     Name = "${var.ENVIRONMENT}-asim-nat-gateway"
#   }
#   depends_on = [aws_internet_gateway.asim-igw]
# }

# ROUTE TABLE FOR PUBLIC SUBNET
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.asim_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.asim-igw.id
  }
  tags = {
    Name = "${var.ENVIRONMENT}-asim-public-route-table"
  }
}

# ROUTE TABLE FOR PRIVATE SUBNET
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.asim_vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.asim-vpc-ngw.id
#   }
#   tags = {
#     Name = "${var.ENVIRONMENT}-asim-private-route-table"
#   }
# }

# Route Table association with public subnets
resource "aws_route_table_association" "to_public_subnet1" {
  subnet_id      = aws_subnet.asim_vpc_public_subnet_01.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "to_public_subnet2" {
  subnet_id      = aws_subnet.asim_vpc_public_subnet_02.id
  route_table_id = aws_route_table.public.id
}

# Route table association with private subnets
# resource "aws_route_table_association" "to_private_subnet1" {
#   subnet_id      = aws_subnet.asim_vpc_private_subnet_01.id
#   route_table_id = aws_route_table.private.id
# }
# resource "aws_route_table_association" "to_private_subnet2" {
#   subnet_id      = aws_subnet.asim_vpc_private_subnet_02.id
#   route_table_id = aws_route_table.private.id
# }

output "my_vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.asim_vpc.id
}

#output "private_subnet1_id" {
#  description = "Subnet ID"
#  value       = aws_subnet.asim_vpc_private_subnet_01.id
#}

#output "private_subnet2_id" {
#  description = "Subnet ID"
#  value       = aws_subnet.asim_vpc_private_subnet_02.id
#}

output "public_subnet1_id" {
  description = "Subnet ID"
  value       = aws_subnet.asim_vpc_public_subnet_01.id
}

output "public_subnet2_id" {
  description = "Subnet ID"
  value       = aws_subnet.asim_vpc_public_subnet_02.id
}
