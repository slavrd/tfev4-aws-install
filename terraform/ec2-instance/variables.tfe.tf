variable "replicated_password" {
  type        = string
  description = "Password to set for the replaicate console."
}

variable "tfe_hostname" {
  type        = string
  description = "Hostname which will be used to access the tfe instance."
}

variable "tfe_enc_password" {
  type        = string
  description = "Encryption password to be used by tfe."
}

variable "tfe_pg_dbname" {
  type        = string
  description = "Name of the PostGRE data base to be used by tfe."
}

variable "tfe_pg_address" {
  type        = string
  description = "Address of the PostGRE data base to be used by tfe. Must contian hostname and optionally a port."
}

variable "tfe_pg_password" {
  type        = string
  description = "Password tfe will use to access the PostGRE data base."
}

variable "tfe_pg_user" {
  type        = string
  description = "Username tfe will use to access the PostGRE data base."
}

variable "tfe_s3_bucket" {
  type        = string
  description = "Name of the S3 bucket tfe will use for object storage."
}

variable "tfe_s3_region" {
  type        = string
  description = "AWS region of the S3 bucket tfe will use for object storage."
}
