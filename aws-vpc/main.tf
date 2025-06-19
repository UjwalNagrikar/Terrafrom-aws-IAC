#EC2 create
resource "aws_instance" "Ujwal-Server" {
    ami = "ami-0f585a71d34f2d32b"
    instance_type = "t2.micro"
    key_name = "Ujwal-SRE"
    subnet_id = aws_subnet.public-subnet-1.id
    associate_public_ip_address = true 
    tags = {
      Name = "Ujwal-Server"
    }
}

#Vpc create
resource "aws_vpc" "Ujwal-VPC" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
      Name = "Ujwal-VPC"
    }
}

#Internet getway 
resource "aws_internet_gateway" "Ujwal-IGW" {
  vpc_id = aws_vpc.Ujwal-VPC.id
  tags = {
    Name = "Ujwal-IGW"
  }
}

#Subnet 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.Ujwal-VPC.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "public-subnet-1"
  }
}

#subnet 2 
resource "aws_subnet" "privet-subnet-2" {
  vpc_id = aws_vpc.Ujwal-VPC.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "privet-subnet"
  }
}

# internet getway 
resource "aws_internet_gateway" "Ujwal-IGW" {
  vpc_id = aws_vpc.Ujwal-VPC.id
  tags = {
    Name = "Ujwal-IGW"
  }
}

#Route Table 
resource "aws_route_table" "my-route" {
  vpc_id = aws_vpc.Ujwal-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Ujwal-IGW.id
  }

  tags = {
    Name = "my-route"
  }
}

# Route table association 
resource "aws_route_table_association" "route-association" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.my-route.id
}