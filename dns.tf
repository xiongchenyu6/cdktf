# DNS Records for autolife.ai

resource "cloudflare_record" "frp_dashboard" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "frp-dashboard"
  content = var.oracle_arm_001_ip  # oracle-arm-001
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "mainpage" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "autolife-robotics.me"
  content = var.oracle_arm_001_ip  # oracle-arm-001
  type    = "A"
  ttl     = 1
  proxied = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "mngt" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "mngt"
  content = var.oracle_arm_001_ip  # oracle-arm-001
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "netbird" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "netbird"
  content = var.oracle_arm_001_ip  # oracle-arm-001
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "rust_server" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "rust-server"
  content = var.oracle_arm_001_ip  # oracle-arm-001
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "vr_sg" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "vr-sg"
  content = var.oracle_arm_001_ip  # oracle-arm-001
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "api" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "api"
  content = var.oracle_arm_001_ip  # oracle-arm-001
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "Hashtopolis" {
  zone_id = cloudflare_zone.xiongchenyu_dpdns_org.id
  name    = "hashtopolis"
  content = var.oracle_arm_002_ip
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "kanidm" {
  zone_id = cloudflare_zone.autolife_ai.id
  name    = "kanidm"
  content = var.oracle_amd_001_ip  # oracle-amd-001 (Kanidm server)
  type    = "A"
  ttl     = 1
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}
