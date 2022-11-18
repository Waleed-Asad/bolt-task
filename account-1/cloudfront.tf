locals {
  s3_test_origin_id = "assets"
}

resource "aws_cloudfront_origin_access_identity" "assets" {
  comment = "assets"
}
#sdk docs site
resource "aws_cloudfront_distribution" "assets" {
  origin {
    domain_name = var.assets_bucket_regional_domain_name
    origin_id = local.s3_test_origin_id

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  aliases = ["assets.example.com"]

  enabled = true
  is_ipv6_enabled = true

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.assets_bucket_regional_domain_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
  tags = {
    Name = "${var.region}-cloudfront-${var.environment}"
    Environment = var.environment
  }

  depends_on = [
   var.assets_bucket_id
  ]
}