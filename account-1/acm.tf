resource "aws_acm_certificate" "cert" {
  domain_name       = "*.example.com"
  validation_method = "DNS"

  tags = {
    Name = "${var.environment}_${var.region}_bolt_assets"
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}