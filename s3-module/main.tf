resource "aws_s3_bucket" "default" {
  bucket                = var.bucket_name
  acl                   = var.acl
  acceleration_status   = var.acceleration_status
  force_destroy         = var.force_destroy
  request_payer         = var.request_payer

versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    id                                     = var.bucket_name
    enabled                                = var.lifecycle_rule_enabled
    prefix                                 = var.bucket_name

    transition {
      days          = var.standard_transition_days 
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.glacier_transition_days 
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration_days
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "my-bucket" {
  bucket = var.bucket_name


# If you want to give public access, you need to go to file: <hourly, daily or weekly.tfvars> and set to false the same variable name
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

depends_on = [
    aws_s3_bucket.default,
  ]
}

resource "aws_s3_bucket_policy" "default" {
  bucket = var.bucket_name

  policy = var.policy_file

depends_on = [
    aws_s3_bucket.default,
  ]
}