resource "aws_instance" "My-Server" {
  ami = "ami-0b09627181c8d5778"
  instance_type = "t2.micro"
  key_name = "Ujwal-SRE"
}