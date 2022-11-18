resource "aws_s3_bucket_policy" "clpoudfront_s3_bolt__access" {
  bucket = aws_s3_bucket.dbricks_root.id

  policy = jsonencode(
  {
    "Version": "2012-10-17",
    "Id": "",
    "Statement": [
      {
        "Sid": "AccessForCloudfrontinAccount1",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity <ORIGIN_ACCESS_ID_IN_CLOUDFRONT>"
        },
        "Action": "s3:GetObject",
        "Resource": "${aws_s3_bucket.bolt-assets.arn}/*"
      }
    ]
  }
  )

  depends_on = [
    aws_s3_bucket.bolt-assets
  ]

  lifecycle {
    ignore_changes = all
  }
}
