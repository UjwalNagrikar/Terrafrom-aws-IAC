resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    tags = {
        Name = "my-vpc"
    }
} 

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr
    tags = {
        Name = "public"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr
    tags = {
        Name = "private"
    }
} 

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "main"
    }
}

resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "main"
    }
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.main.id
}