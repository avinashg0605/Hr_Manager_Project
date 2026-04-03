#################################
# VPC
#################################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = local.names.vpc
  })
}

#################################
# Internet Gateway
#################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = local.names.igw
  })
}

#################################
# Public Subnets
#################################

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[0]
  availability_zone       = local.availability_zone_1
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${local.names.public_subnet_1}"
  })
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[1]
  availability_zone       = local.availability_zone_2
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${local.names.public_subnet_2}"
  })
}

#################################
# Private Subnets
#################################

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[0]
  availability_zone = local.availability_zone_1

  tags = merge(local.common_tags, {
    Name = "${local.names.private_subnet_1}"
  })
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[1]
  availability_zone = local.availability_zone_2

  tags = merge(local.common_tags, {
    Name = "${local.names.private_subnet_2}"
  })
}

#################################
# Route Tables
#################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = local.names.public_rt
  })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = local.names.private_rt
  })
}

#################################
# Routes
#################################

# Public → Internet
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

#################################
# NAT Gateway (for private subnet internet)
#################################

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(local.common_tags, {
    Name = "${local.project_name}-eip"
  })
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id  # must be public subnet

  tags = merge(local.common_tags, {
    Name = local.names.nat
  })

  depends_on = [aws_internet_gateway.igw]
}

# Private → Internet via NAT
resource "aws_route" "private_internet" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

#################################
# Route Table Associations
#################################

# Public Subnets → Public Route Table
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

# Private Subnets → Private Route Table
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}