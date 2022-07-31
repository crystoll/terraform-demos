
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "eu-north-1"
  profile = "terraforming"

  default_tags {
    tags = {
      application = "terraform-s3-remote-state"
    }
  }
}


resource "aws_s3_bucket" "terraform_s3_state" {
  bucket_prefix = "tfstate-dev-"
  force_destroy = true
  #   force_destroy = false
  #   lifecycle {
  #     prevent_destroy = true
  #   }
}


resource "aws_dynamodb_table" "s3-terraform_state_lock" {
  name           = "tfstate-lock-dev"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


##### Optional extras

resource "aws_s3_bucket_public_access_block" "terraform_s3_state" {
  bucket                  = aws_s3_bucket.terraform_s3_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "terraform_s3_state" {
  bucket = aws_s3_bucket.terraform_s3_state.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_s3_state" {
  bucket = aws_s3_bucket.terraform_s3_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform_s3_state" {
  bucket = aws_s3_bucket.terraform_s3_state.id
  versioning_configuration {
    status = "Enabled"
  }
}



output "terraform_s3_state_bucket_id" {
  value = aws_s3_bucket.terraform_s3_state.id
}

output "s3-terraform_state_lock-dynamodb_table" {
  value = aws_dynamodb_table.s3-terraform_state_lock.name
}



