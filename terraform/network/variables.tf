variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for the VPC to create."
}

variable "public_subnets_cidrs" {
  type        = map(number)
  description = "Map containing the public subnets CIDRs as keys and number as value. The number is used to determine the AWS vailability zone in which the subnet will be created. It is used as an list index to select an AZ in the current AWS region. The map must contain atleast two key/value pairs."

}

variable "private_subnets_cidrs" {
  type        = map(number)
  description = "Map containing the private subnets CIDRs as keys and number as value. The number is used to determine the AWS vailability zone in which the subnet will be created. It is used as an list index to select an AZ in the current AWS region. The map must contain atleast two key/value pairs."

}

variable "lb_internal" {
  type        = bool
  description = "Whether to create internal load balancer."
  default     = false
}

variable "name_prefix" {
  type        = string
  description = "A string to be used as prefix for generating names of the created resources"
  default     = "ptfe-"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to assign to all resources"
  default     = {}
}