resource "aws_kms_key" "bolt-key" {
  description             = "KMS key for s3 Assets"
  deletion_window_in_days = 10
}