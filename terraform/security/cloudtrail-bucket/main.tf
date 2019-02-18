provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "${var.role_arn}"
  }
}

terraform {
  backend "s3" {
    key = "cloudtrail-bucket.tfstate"
  }
}

module "cloudtrail_bucket" {
  source = "../../modules/cloudtrail-bucket"

  kms_key_arn = "${data.terraform_remote_state.sec.kms_key_arn}"
  env         = "${var.env}"
}
