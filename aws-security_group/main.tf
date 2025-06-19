# Security group 
resource "aws_security_group" "my-security-group" {
  
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = "vpc-0473ebd347ec8b538"

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
    Name = "my_security_group"
  }
}

# EC2 with Security group 

resource "aws_instance" "my-Server" {
  
  ami = "ami-0f918f7e67a3323io"
  instance_type = "t2.micro"
  key_name = "Ujwal-SRE"

  vpc_security_group_ids = [ aws_security_group.my-security-group.id ]
}