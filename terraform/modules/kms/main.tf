resource "aws_kms_key" "key" {
  description         = "${var.env}-kms-key"
  enable_key_rotation = true
  policy              = "${var.policy}"

  tags {
    Name = "${var.env}-kms-key"
    Env  = "${var.env}"
  }
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.env}"
  target_key_id = "${aws_kms_key.key.key_id}"
}
