provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = "${var.role_arn}"
  }
}

terraform {
  backend "s3" {
    key = "route53.tfstate"
  }
}

module "route53" {
  source = "../../modules/route53"

  env    = "${var.env}"
  domain = "example.com"
}

resource "aws_route53_record" "gapps" {
  zone_id = "${module.route53.zone_id}"
  name    = "example.com"
  type    = "MX"
  ttl     = "86400"

  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ASPMX2.GOOGLEMAIL.COM",
    "10 ASPMX3.GOOGLEMAIL.COM",
  ]
}
