# Cloudflare DNS Infrastructure

Terraform configuration for managing Cloudflare zones and DNS records.

## Managed by Terraform Cloud

This repository is configured to use Terraform Cloud for all operations.

- Organization: `autolife-robotics`
- Workspace: `cloudflare-dns`
- Triggers: VCS-driven workflow from GitHub

## Structure

```
terraform/
├── main.tf       # Provider and backend configuration
├── variables.tf  # Variable definitions
├── zones.tf      # Cloudflare zones
└── dns.tf        # DNS records
```

## Setup in Terraform Cloud

1. Workspace is already connected to this GitHub repository
2. Variables to set in Terraform Cloud:
   - `cloudflare_api_token` (sensitive) - Your Cloudflare API token

## Local Development (Optional)

```bash
cd terraform
terraform init
terraform plan
```

Note: Local runs will still use Terraform Cloud for state storage.