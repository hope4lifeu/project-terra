provider "aws" {
    region = "us-west-2"
  
}

resource "aws_s3_bucket" "bootkmp30-01-richard" {
  bucket = "bootkmp30-01-richard"
}

resource "aws_kms_key" "rkey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "serverconf" {
  bucket = aws_s3_bucket.bootkmp30-01-richard.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.rkey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
