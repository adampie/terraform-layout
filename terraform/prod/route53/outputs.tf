output "zone_id" {
  value = "${module.route53.zone_id}"
}

output "name_servers" {
  value = "${module.route53.name_servers}"
}
