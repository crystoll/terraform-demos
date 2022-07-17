
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_configuration" {
  bucket = aws_s3_bucket.my_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

resource "aws_s3_bucket_acl" "my_bucket" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}


