variable "replicated_password" {
  type        = string
  description = "Password to set for the replaicate console."
  default     = "Password123#"
}

variable "ptfe_hostname" {
  type        = string
  description = "Hostname which will be used to access the PTFE instance."
}

variable "ptfe_enc_password" {
  type        = string
  description = "Encryption password to be used by PTFE."
  default     = "Password123#"
}

variable "ptfe_pg_dbname" {
  type        = string
  description = "Name of the PostGRE data base to be used by PTFE."
}

variable "ptfe_pg_address" {
  type        = string
  description = "Address of the PostGRE data base to be used by PTFE. Must contian hostname and optionally a port."
}

variable "ptfe_pg_password" {
  type        = string
  description = "Password PTFE will use to access the PostGRE data base."
}

variable "ptfe_pg_user" {
  type        = string
  description = "Username PTFE will use to access the PostGRE data base."
}

variable "ptfe_s3_bucket" {
  type        = string
  description = "Name of the S3 bucket PTFE will use for object storage."
}

variable "ptfe_s3_region" {
  type        = string
  description = "AWS region of the S3 bucket PTFE will use for object storage."
}
