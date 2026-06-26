# Hurricane Electric DNS (dns.he.net) — manages records for sex.qd.je.
# HE has no API/token; the provider logs into the web UI with username/password.
# No 2FA on this account, so store_type = "dummy" (nothing persisted to disk),
# which is what you want for ephemeral Terraform Cloud remote runs.
provider "dns-he-net" {
  username   = var.he_username
  password   = var.he_password
  store_type = "dummy"
}

# Read-only: lists the zones on the HE account. Confirms the credentials work in
# the Terraform Cloud run. Safe — creates nothing.
data "dns-he-net_domain_zones" "all" {}

output "he_zones" {
  description = "Zones visible on the Hurricane Electric account (id + name)."
  value       = data.dns-he-net_domain_zones.all.zones
}

# sex.qd.je zone id in HE (from dns.he.net URL ?hosted_dns_zoneid=1309596).
locals {
  sex_qd_je_zid = 1309596
}

# --- Records for sex.qd.je go here. Example (edit `data`, then uncomment): ---
#
# resource "dns-he-net_a" "sex_apex" {
#   zone_id = local.sex_qd_je_zid
#   domain  = "sex.qd.je"     # full FQDN, not just the prefix
#   ttl     = 3600
#   data    = "1.2.3.4"
# }
