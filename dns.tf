# DNS Records for autolife.ai

resource "cloudflare_record" "frp_dashboard" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "frp-dashboard"
  content =var.home_ip
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "mainpage" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "autolife-robotics.me"
  content =var.home_ip
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "mngt" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "mngt"
  content =var.home_ip
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "netbird" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "netbird"
  content =var.home_ip
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "rust_server" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "rust-server"
  content =var.home_ip
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "vr_sg" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "vr-sg"
  content =var.home_ip
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "www"
  content =var.home_ip
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "api" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "api"
  content =var.home_ip
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "freeman_cname" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "freeman"
  content ="cname.vercel-dns.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "kanidm" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "kanidm"
  content =var.kanidm_ip
  type    = "A"
  ttl     = 1
  proxied = false
}