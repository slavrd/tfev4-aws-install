variable "common_tags" {
  type        = map(string)
  description = "Common tags to assign to all resources"
  default     = {}
}

variable "name_prefix" {
  type        = string
  description = "A string to be used as prefix for generating names of the created resources"
  default     = "ptfe-"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the s3 bucket to create."
}

variable "s3_bucket_region" {
  type        = string
  description = "The AWS region in which to create the s3 bucket."
}