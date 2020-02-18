variable "vpc_id" {
  type        = string
  description = "Id of the VPC in which to deploy the PTFE instance."
}

variable "subnet_id" {
  type        = string
  description = "Subnet in which to create PTFE instance."
}

variable "ami_id" {
  type        = string
  description = "The AMI Id to use for the tfe instance. Needs to have the TFE arigap package and Replicated installer."
}

variable "key_name" {
  type        = string
  description = "Name of the AWS key pair to use for the PTFE instance."
}

variable "common_tags" {
  type        = map(string)
  description = "The common tags to use with the managed resources. The default vaule is used as an example."
  default = {
    owner   = ""
    project = ""
  }
}

variable "instance_type" {
  type        = string
  description = "The AWS instance type to use."
  default     = "m5a.large"
}
