resource "aws_s3_bucket" "data_source" {
  bucket = "raul-tflearning-2023-data-source"

  tags = {
    Project = "raul-tflearning-2023"
  }
}

resource "aws_s3_bucket_public_access_block" "data_source_access_block" {
  bucket = aws_s3_bucket.data_source.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}