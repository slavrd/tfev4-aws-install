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
