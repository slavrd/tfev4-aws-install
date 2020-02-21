variable "vpc_id" {
  type        = string
  description = "Id of the VPC in which to deploy the PTFE instance."
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "Subnet in which to create PTFE instance."
  default     = null
}

variable "ami_id" {
  type        = string
  description = "The AMI Id to use for the tfe instance. Needs to have the TFE arigap package and Replicated installer."
}

variable "common_tags" {
  type        = map(string)
  description = "The common tags to use with the managed resources. The default vaule is used as an example."
  default = {
    owner   = "packer-test-ptfev4-aws-playgroud"
    project = "packer-test-ptfev4-aws-playgroud"
  }
}

variable "instance_type" {
  type        = string
  description = "The AWS instance type to use."
  default     = "t2.micro"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to use."
}
