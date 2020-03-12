variable "ami_id" {
  type        = string
  description = "The AMI Id to use for the tfe instance. Needs to have the TFE arigap package and Replicated installer."
}

variable "key_name" {
  type        = string
  description = "Name of the AWS key pair to use for the PTFE instance."
}

variable "instance_type" {
  type        = string
  description = "The AWS instance type to use."
  default     = "m5a.large"
}

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
