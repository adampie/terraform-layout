provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "${var.role_arn}"
  }
}

terraform {
  backend "s3" {
    key = "kms.tfstate"
  }
}

module "kms" {
  source = "../../modules/kms"

  env = "${var.env}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.aws_account}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOF
}
