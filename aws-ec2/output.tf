output "instance_id" {
  value       = aws_instance.myserver.id
}

output "public_ip" {
  value = aws_instance.myserver.public_ip
}

output "arn" {
  value = aws_instance.myserver.arn
}