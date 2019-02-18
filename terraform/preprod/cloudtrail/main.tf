provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "${var.role_arn}"
  }
}

terraform {
  backend "s3" {
    key = "cloudtrail.tfstate"
  }
}

module "cloudtrail" {
  source = "../../modules/cloudtrail"

  env                  = "${var.env}"
  cloudtrail_s3_bucket = "example-cloudtrail-security"
  kms_key_arn          = "${data.terraform_remote_state.sec.kms_key_arn}"
}
