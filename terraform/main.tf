module "network" {
  source = "./network"

  vpc_cidr_block        = var.vpc_cidr_block
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  name_prefix           = var.name_prefix
  common_tags           = var.common_tags

}

module "external_services" {
  source = "./ext-services"

  s3_bucket_name   = var.s3_bucket_name
  s3_bucket_region = var.s3_bucket_region

  pg_vpc_id                  = module.network.vpc_id
  pg_subnet_ids              = module.network.private_subnets_ids
  pg_identifier_prefix       = var.name_prefix
  pg_instance_class          = var.pg_instance_class
  pg_engine_version          = var.pg_engine_version
  pg_allocated_storage       = var.pg_allocated_storage
  pg_storage_type            = var.pg_storage_type
  pg_multi_az                = var.pg_multi_az
  pg_parameter_group_name    = var.pg_parameter_group_name
  pg_deletion_protection     = var.pg_deletion_protection
  pg_backup_retention_period = var.pg_backup_retention_period
  pg_db_name                 = var.pg_db_name
  pg_username                = var.pg_username
  pg_password                = var.pg_password

  common_tags = var.common_tags
}

module "ptfe_instance" {
  source = "./ec2-instance"

  vpc_id              = module.network.vpc_id
  subnet_id           = module.network.public_subnets_ids[0]
  ami_id              = var.ami_id
  key_name            = var.key_name
  instance_type       = var.instance_type
  replicated_password = var.replicated_password
  ptfe_hostname       = var.ptfe_hostname
  ptfe_enc_password   = var.ptfe_enc_password
  ptfe_pg_dbname      = var.pg_db_name
  ptfe_pg_address     = module.external_services.pg_address
  ptfe_pg_password    = var.pg_password
  ptfe_pg_user        = var.pg_username
  ptfe_s3_bucket      = module.external_services.s3_bucket_name
  ptfe_s3_region      = var.s3_bucket_region

  common_tags = var.common_tags
}

locals {
  ptfe_hostname_split = split(".", var.ptfe_hostname)
}

module "ptfe_dns" {
  source = "./dns"

  cname_value      = module.ptfe_instance.ptfe_instance_public_dns
  cname_record     = element(local.ptfe_hostname_split, 0)
  hosted_zone_name = join(".", slice(local.ptfe_hostname_split, 1, length(local.ptfe_hostname_split)))
}
