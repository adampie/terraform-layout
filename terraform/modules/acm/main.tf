resource "aws_acm_certificate" "cert" {
  domain_name               = "${var.domain}"
  subject_alternative_names = ["*.${var.domain}"]
  validation_method         = "DNS"

  tags = {
    Name        = "${var.domain}"
    Environment = "${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  zone_id = "${var.zone_id}"
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]

  depends_on = ["aws_acm_certificate.cert"]
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.validation.fqdn}"]
}
