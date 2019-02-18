resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "example-cloudtrail-${var.env}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${var.kms_key_arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "AWSCloudTrailAclCheck",
          "Effect": "Allow",
          "Principal": {
            "Service": "cloudtrail.amazonaws.com"
          },
          "Action": "s3:GetBucketAcl",
          "Resource": "arn:aws:s3:::example-cloudtrail-${var.env}"
      },
      {
          "Sid": "AWSCloudTrailWrite",
          "Effect": "Allow",
          "Principal": {
            "Service": "cloudtrail.amazonaws.com"
          },
          "Action": "s3:PutObject",
          "Resource": "arn:aws:s3:::example-cloudtrail-${var.env}/*",
          "Condition": {
              "StringEquals": {
                  "s3:x-amz-acl": "bucket-owner-full-control",
                  "s3:x-amz-server-side-encryption": "aws:kms"
              }
          }
      }
  ]
}
EOF

  tags {
    Name        = "example-cloudtrail-${var.env}"
    Environment = "${var.env}"
  }
}
