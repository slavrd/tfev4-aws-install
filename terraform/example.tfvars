vpc_cidr_block = "172.30.16.0/20"

# Type is required by the used network module.
# For each subnet it is needed to provide a CIDR and AZ in which to place it. 
# The AZ is provided as a number. This number is used as index to select an AZ from the list of AZs for the current AWS region.
public_subnets_cidrs = [
  {
    cidr     = "172.30.16.0/24"
    az_index = 0
  },
  {
    cidr     = "172.30.17.0/24"
    az_index = 1
  },
]
private_subnets_cidrs = [
  {
    cidr     = "172.30.24.0/24"
    az_index = 0
  },
  {
    cidr     = "172.30.25.0/24"
    az_index = 1
  },
]

name_prefix = "my-tfe-"

ami_id          = "my.tfe.install.ami.id"
key_name        = "my-key-pair"
key_pair_create = true
tfe_hostname   = "tfe.domain.com"

s3_bucket_name      = "my-tfe"
s3_bucket_region    = "eu-central-1"
pg_password         = "Password123#"
replicated_password = "Password123#"
tfe_enc_password    = "Password123#"

common_tags = {
  owner   = "owner@domain.com"
  project = "terraform-tfe"
}
