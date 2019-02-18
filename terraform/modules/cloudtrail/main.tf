resource "aws_cloudtrail" "cloudtrail" {
  name                       = "cloudtrail"
  s3_bucket_name             = "${var.cloudtrail_s3_bucket}"
  is_multi_region_trail      = true
  enable_log_file_validation = true
  kms_key_id                 = "${var.kms_key_arn}"

  # Bucket object logging cross account is broken at the moment
  is_organization_trail = false

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3"]
    }

    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }

  tags {
    Name = "cloudtrail"
  }
}
