resource "aws_s3_bucket" "ptfe_s3_bucket" {
  bucket = var.s3_bucket_name
  region = var.s3_bucket_region
  acl    = "private"

  tags = var.common_tags
}