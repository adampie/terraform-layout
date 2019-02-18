output "key_arn" {
  value = "${aws_kms_key.key.arn}"
}

output "key_key_id" {
  value = "${aws_kms_key.key.key_id}"
}

output "alias_arn" {
  value = "${aws_kms_alias.alias.arn}"
}

output "alias_target_key_arn" {
  value = "${aws_kms_alias.alias.target_key_arn}"
}
