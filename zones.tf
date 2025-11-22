resource "cloudflare_zone" "autolife_ai" {
  account_id = var.cloudflare_account_id
  zone       = "autolife.ai"
}

resource "cloudflare_zone" "autolife_dpdns_org" {
  account_id = var.cloudflare_account_id
  zone       = "autolife.dpdns.org"
}

resource "cloudflare_zone" "xiongchenyu_dpdns_org" {
  account_id = var.cloudflare_account_id
  zone       = "xiongchenyu.dpdns.org"
}