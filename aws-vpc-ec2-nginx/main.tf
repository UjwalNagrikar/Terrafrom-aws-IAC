# EC2 instance For Nginx setup

resource "aws_instance" "my-server" {
  ami = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  key_name =  "Ujwal-SRE"
  subnet_id = aws_subnet.public-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.my-sg.id ]

  user_data = <<-EOF
            apt update 
            apt install nginx 
            systemctl start nginx
  EOF
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "privet_subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "privet-subnet"
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "my-rt-a" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_security_group" "my-sg" {
  vpc_id = aws_vpc.my-vpc.id
  description = "allow http and ssh trafic"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}