vpc_cidr_block = "172.30.16.0/20"

# my own module expect "cidr" = "AZ"
public_subnets_cidrs = {
  "172.30.16.0/24" = 0
  "172.30.16.0/24" = 1
}

# my own module expect "cidr" = "AZ"
private_subnets_cidrs = {
  "172.30.24.0/24" = 0
  "172.30.25.0/24" = 1
}

name_prefix = "my-ptfev4-"

ami_id          = "my.ptfe.install.ami.id"
key_name        = "my-key-pair"
key_pair_create = true
ptfe_hostname   = "ptfev4.domain.com"

s3_bucket_name   = "my-ptfev4"
s3_bucket_region = "eu-central-1"
pg_password      = "Password123#"


common_tags = {
  owner   = "owner@domain.com"
  project = "terraform-ptfev4"
}
