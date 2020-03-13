output "ptfe_address" {
  value       = "https://${var.ptfe_hostname}"
  description = "Address for accessing the PTFE instance"
}

output "replicated_address" {
  value       = "https://${var.ptfe_hostname}:8800"
  description = "Address for accessing the replicate console"
}

output "private_key" {
  value       = var.key_pair_create ? module.key_pair.private_key : ""
  description = "The private key of the TLS key pair if such was created."
}