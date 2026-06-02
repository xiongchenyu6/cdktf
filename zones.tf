resource "cloudflare_zone" "autolife_ai" {
  account = {
    id = var.cloudflare_account_id
  }
  name = "autolife.ai"
}

resource "cloudflare_zone" "panda_qzz_io" {
  account = {
    id = var.cloudflare_account_id
  }
  name = "panda.qzz.io"
}

# Zones no longer exist in Cloudflare; clear from state without a destroy API call.
removed {
  from = cloudflare_zone.lovai_eu_org

  lifecycle {
    destroy = false
  }
}

removed {
  from = cloudflare_zone.autolife_dpdns_org

  lifecycle {
    destroy = false
  }
}
