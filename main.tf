terraform {
  required_version = ">= 1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }

  # HCP Terraform workspace "xiongchenyu6" (org autolife-robotics), VCS-driven
  # from github.com/xiongchenyu6/terraform. Auto-apply is off — runs trigger on
  # push but apply is confirmed manually.
  cloud {
    organization = "autolife-robotics"

    workspaces {
      name = "xiongchenyu6"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
