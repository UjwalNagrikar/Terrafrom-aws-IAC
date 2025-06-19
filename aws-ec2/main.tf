resource "aws_instance" "myserver" {
  ami           = "ami-0f535a71b34f2d44a"
  instance_type = "t2.micro"
  

  tags = {
    Name = "My-Server"
  }
}