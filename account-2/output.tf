output "assets_bucket_id" {
  value = aws_s3_bucket.bolt-assets.id
}

output "assets_bucket_regional_domain_name" {
  value = aws_s3_bucket.bolt-assets.bucket_regional_domain_name
}