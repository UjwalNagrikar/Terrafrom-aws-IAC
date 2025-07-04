resource "aws_instance" "myserver" {
  ami           = "ami-0f535a71b34f2d44a"
  instance_type = "t2.micro"
  associate_public_ip_address = true

  lifecycle {
    prevent_destroy = true
  }
  
  tags = {
    Name = "My-Server"
  }
}
