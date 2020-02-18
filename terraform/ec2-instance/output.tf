output "ptfe_instance_public_ip" {
  value       = aws_instance.ptfe.public_ip
  description = "Public IP address of the PTFE instance"
}

output "ptfe_instance_public_dns" {
  value       = aws_instance.ptfe.public_dns
  description = "Public DNS address of the PTFE instance"
}

output "ptfe_instance_private_ip" {
  value       = aws_instance.ptfe.private_ip
  description = "Private IP address of the PTFE instance"
}

output "ptfe_instance_private_dns" {
  value       = aws_instance.ptfe.private_dns
  description = "Private DNS address of the PTFE instance"
}