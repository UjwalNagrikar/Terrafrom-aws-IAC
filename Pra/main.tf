resource "aws_security_group" "my-sg" {
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = "vpc-0473ebd347ec8b538"
  tags = {
    Name = "my-sg"
  }
}
resource "aws_instance" "ec2-instance" {
    ami = "ami-0b09627181c8d5778"
    instance_type = "t2.micro"
    key_name = "Ujwal-SRE"
    vpc_security_group_ids = [ aws_security_group.my-sg.id ]
    depends_on = [ aws_security_group.my-sg ]
}