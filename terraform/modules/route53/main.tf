resource "aws_route53_zone" "zone" {
  name = "${var.domain}."

  tags = {
    Name        = "${var.domain}."
    Environment = "${var.env}"
  }
}

resource "aws_route53_query_log" "query_log" {
  depends_on = ["aws_cloudwatch_log_resource_policy.logging_resource_policy"]

  cloudwatch_log_group_arn = "${aws_cloudwatch_log_group.log_group.arn}"
  zone_id                  = "${aws_route53_zone.zone.zone_id}"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/route53/${aws_route53_zone.zone.name}"
  retention_in_days = 30
}

data "aws_iam_policy_document" "logging_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "logging_resource_policy" {
  policy_document = "${data.aws_iam_policy_document.logging_policy.json}"
  policy_name     = "route53-logging-policy"
}
