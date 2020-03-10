output "vpc_id" {
  value       = module.ptfe-network.vpc_id
  description = "Id of the created VPC."
}

output "public_subnets_ids" {
  value       = module.ptfe-network.public_subnet_ids
  description = "List of the ids of the public subnets."
}

output "private_subnets_ids" {
  value       = module.ptfe-network.private_subnet_ids
  description = "List of the ids of the public subnets."
}