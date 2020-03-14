variable "vpc_id" {
  type        = string
  description = "Id of the VPC in which to deploy the PTFE instance."
}

variable "subnets_ids" {
  type        = list(string)
  description = "List of subnet ids in which to create PTFE instance."
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

variable "name_prefix" {
  type        = string
  description = "Name prefix to use when creating names for resources."
  default     = "ptfev4-"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Wether to associate public ip address with the isntance. Shold be false except if bringin a standalone instance for testing."
  default     = false
}

variable "target_groups_arns" {
  type        = list(string)
  description = "List of target group arns in which to register the auto scaling group instances."
}
