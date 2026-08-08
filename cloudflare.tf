# Cloudflare zones and DNS records (personal)

resource "cloudflare_zone" "panda_qzz_io" {
  account = {
    id = var.cloudflare_account_id
  }
  name = "panda.qzz.io"
}

resource "cloudflare_zone" "boob_qzz_io" {
  account = {
    id = var.cloudflare_account_id
  }
  name = "boob.qzz.io"
}

resource "cloudflare_dns_record" "casibase" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "casibase"
  content = var.gz_office_ip
  type    = "A"
  ttl     = 1
  proxied = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "wgmesh" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "wgmesh"
  content = var.oracle_amd_002_ip
  type    = "A"
  ttl     = 1
  proxied = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "hashtopolis" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "hashtopolis"
  content = var.oracle_arm_002_ip
  type    = "A"
  ttl     = 1
  proxied = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "api" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "api"
  content = var.oracle_arm_002_ip
  type    = "A"
  ttl     = 1
  proxied = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "auth" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "auth"
  content = var.oracle_arm_002_ip
  type    = "A"
  ttl     = 1
  proxied = true

  lifecycle {
    create_before_destroy = true
  }
}

# DNS-only record for direct PostgreSQL access (port 5432). Cloudflare's proxy
# only tunnels HTTP/HTTPS on Free/Pro, so `quant` users connect here rather than
# the proxied `api` subdomain.
resource "cloudflare_dns_record" "db" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "db"
  content = var.oracle_arm_002_ip
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

# Supabase Realtime (WebSockets) — proxied through Cloudflare, which supports WS
# on Free. Long-lived connections; origin nginx bumps proxy_read_timeout.
resource "cloudflare_dns_record" "realtime" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "realtime"
  content = var.oracle_arm_002_ip
  type    = "A"
  ttl     = 1
  proxied = true

  lifecycle {
    create_before_destroy = true
  }
}

# Wildcard for per-tenant subdomain routing (realtime's Host-based tenant
# dispatch: <external_id>.realtime.panda.qzz.io). Not available on Cloudflare
# Free, so this record stays DNS-only.
resource "cloudflare_dns_record" "realtime_wildcard" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "*.realtime"
  content = var.oracle_arm_002_ip
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

# Worldsmith managed-ComfyUI ingress (replaces the expired
# comfy.autolfie.ddns.net no-ip entry). Points straight at sg-office's
# static public IP — the box's caddy (services.comfyui-proxy in the
# autolife nixos repo) terminates TLS + bearer auth itself, same as
# the DDNS era. DNS-only: proxying through Cloudflare would add the
# 100s edge timeout on top of multi-minute video renders for no
# benefit — the Pages Function is the only intended client.
resource "cloudflare_dns_record" "comfy" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "comfy"
  content = var.sg_office_ip
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "sub2api" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "sub2api"
  content = var.oracle_amd_002_ip
  type    = "A"
  ttl     = 1
  proxied = true

  lifecycle {
    create_before_destroy = true
  }
}

# Resend email setup for panda.qzz.io
resource "cloudflare_dns_record" "resend_dkim" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "resend._domainkey"
  content = "p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDKD5wgZJUU75tlqctIv+Am5nYMt1L+FiXuxa9Htb+OlzN6O8r6hv6be56V8uu4aqBm66/2PBvYxN6tic/QK4AgGKxRcSTv5DhIlxcc0sFfU3+dXHAywPIedt4ziVOx6NfKUf4PDPhlgHzRdJwmfAqlTG8CsMbOCo3YU6ueFxFxpQIDAQAB"
  type    = "TXT"
  ttl     = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "inbound_mx" {
  zone_id  = cloudflare_zone.panda_qzz_io.id
  name     = "@"
  content  = "inbound-smtp.ap-northeast-1.amazonaws.com"
  type     = "MX"
  priority = 10
  ttl      = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "resend_mx" {
  zone_id  = cloudflare_zone.panda_qzz_io.id
  name     = "send"
  content  = "feedback-smtp.ap-northeast-1.amazonses.com"
  type     = "MX"
  priority = 10
  ttl      = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "resend_spf" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "send"
  content = "v=spf1 include:amazonses.com ~all"
  type    = "TXT"
  ttl     = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "dmarc" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "_dmarc"
  content = "v=DMARC1; p=none;"
  type    = "TXT"
  ttl     = 1

  lifecycle {
    create_before_destroy = true
  }
}
