terraform {
  required_version = ">= 1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  cloud {
    hostname     = "app.terraform.io"
    organization = "autolife-robotics"

    workspaces {
      name = "cdktf"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}