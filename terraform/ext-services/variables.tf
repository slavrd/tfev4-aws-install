variable "common_tags" {
  type        = map(string)
  description = "Tags to apply to all resources."
  default     = {}
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the s3 bucket to create."
}

variable "s3_bucket_region" {
  type        = string
  description = "The AWS region in which to create the s3 bucket."
}

variable "pg_subnet_ids" {
  type        = list(string)
  description = "List of AWS subent ids to use for PostgreSQL DB subnet group."
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC in which the PostgreSQL instance is being created. Used to create the security group."
}