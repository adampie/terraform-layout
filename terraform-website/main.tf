provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "${var.role_arn}"
  }
}

terraform {
  backend "s3" {
    key = "website.tfstate"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.domain}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "${var.domain}"
    Environment = "${var.env}"
  }
}
