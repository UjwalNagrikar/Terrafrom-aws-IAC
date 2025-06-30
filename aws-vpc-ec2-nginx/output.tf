output "aws_instance" {
  value = aws_instance.my-server.id
}

output "aws_vpc" {
  value = aws_vpc.my-vpc.id
}

output "url" {
value = "http://${aws_instance.my-server.public_ip}"
}