output "ec2_public_ip" {
  value = aws_instance.audit_ec2.public_ip
}
