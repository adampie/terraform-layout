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
        },
        {
            "Sid": "Allow CloudTrail to encrypt logs",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "kms:GenerateDataKey*",
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "kms:EncryptionContext:aws:cloudtrail:arn": [
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*"
                    ]
                }
            }
        },
        {
            "Sid": "Allow CloudTrail to describe key",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "kms:DescribeKey",
            "Resource": "*"
        },
        {
            "Sid": "Allow principals in the account to decrypt log files",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "kms:Decrypt",
                "kms:ReEncryptFrom"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "kms:CallerAccount": [
                        "00000000000",
                        "00000000000",
                        "00000000000",
                        "00000000000",
                        "00000000000"
                    ]
                },
                "StringLike": {
                    "kms:EncryptionContext:aws:cloudtrail:arn": [
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*"
                    ]
                }
            }
        },
        {
            "Sid": "Allow alias creation during setup",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "kms:CreateAlias",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "kms:CallerAccount": [
                        "00000000000",
                        "00000000000",
                        "00000000000",
                        "00000000000",
                        "00000000000"
                    ],
                    "kms:ViaService": "ec2.aws_region_name.amazonaws.com"
                }
            }
        },
        {
            "Sid": "Enable cross account log decryption",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "kms:Decrypt",
                "kms:ReEncryptFrom"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "kms:CallerAccount": [
                        "00000000000",
                        "00000000000",
                        "00000000000",
                        "00000000000",
                        "00000000000"
                    ]
                },
                "StringLike": {
                    "kms:EncryptionContext:aws:cloudtrail:arn": [
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*",
                        "arn:aws:cloudtrail:*:00000000000:trail/*"
                    ]
                }
            }
        }
    ]
}
EOF
}
