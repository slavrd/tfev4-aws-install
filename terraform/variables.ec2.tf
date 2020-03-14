variable "ami_id" {
  type        = string
  description = "The AMI Id to use for the tfe instance. Needs to have the TFE arigap package and Replicated installer."
}

variable "key_name" {
  type        = string
  description = "Name of the AWS key pair to use for the PTFE instance."
}

variable "key_pair_create" {
  type        = bool
  description = "Wether to create an AWS key pair at all."
  default     = false
}

variable "public_key_path" {
  type        = string
  description = "Public key to use for the AWS key pair createion. If not provided a new TLS public/private key pair will be generated."
  default     = ""
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

variable "ptfe_associate_public_ip_address" {
  type        = bool
  description = "Wether to associate public ip address with the isntance. Shold be false except if bringin a standalone instance for testing."
  default     = false
}
