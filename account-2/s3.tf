resource "aws_s3_bucket" "bolt-assets" {
  bucket  = "${var.environment}-${var.region}-bolt-assets"

  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.bolt-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name = "${var.environment}-${var.region}-bolt-assets"
    Environment = var.environment
  }

  depends_on = [
    aws_kms_key.bolt-key
  ]
}