# Cloudflare Infrastructure with Terraform

This directory contains pure Terraform configuration for managing Cloudflare zones and DNS records.

## Prerequisites

- Terraform >= 1.0
- Cloudflare API Token with the following permissions:
  - Zone:Read
  - Zone:Edit
  - DNS:Read
  - DNS:Edit
- Terraform Cloud account (optional, for remote state)

## Structure

- `main.tf` - Terraform configuration and provider setup
- `variables.tf` - Input variable definitions
- `zones.tf` - Cloudflare zone resources
- `dns.tf` - DNS record resources
- `terraform.tfvars.example` - Example variables file

## Setup

### 1. Local Setup

```bash
# Copy example variables file
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your Cloudflare API token
vim terraform.tfvars

# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Apply changes
terraform apply
```

### 2. Using Terraform Cloud

The configuration is set up to use Terraform Cloud for remote state management.

1. Set your Cloudflare API token in Terraform Cloud:
   - Go to https://app.terraform.io/app/autolife-robotics/cdktf/variables
   - Add variable: `cloudflare_api_token`
   - Mark as sensitive

2. Run Terraform:
```bash
terraform init
terraform plan
terraform apply
```

### 3. GitHub Actions

The workflow automatically runs on:
- Pull requests (plan only)
- Pushes to main branch (apply)
- Manual trigger

Required GitHub Secrets:
- `TF_API_TOKEN` - Terraform Cloud API token

## Resources Managed

### Zones
- `autolife.ai`
- `autolife.dpdns.org`
- `xiongchenyu.dpdns.org`

### DNS Records (autolife.ai)
- A Records: frp-dashboard, mainpage, mngt, netbird, rust-server, vr-sg, www, api, kanidm
- CNAME Records: freeman

## Commands

```bash
# Format code
terraform fmt

# Validate configuration
terraform validate

# Show current state
terraform show

# Import existing resources
terraform import cloudflare_zone.autolife_ai <zone-id>

# Destroy all resources (careful!)
terraform destroy
```

## Migrating from CDKTF

If you have existing resources managed by CDKTF:

1. Import existing resources:
```bash
terraform import cloudflare_zone.autolife_ai <existing-zone-id>
terraform import cloudflare_record.www <existing-record-id>
# ... import other resources
```

2. Or start fresh:
```bash
# Destroy old CDKTF resources first
cd ..
cdktf destroy

# Then apply new Terraform config
cd terraform
terraform apply
```

## Troubleshooting

### Authentication Error
Ensure your Cloudflare API token has the required permissions and is correctly set in:
- `terraform.tfvars` for local runs
- Terraform Cloud variables for remote runs
- GitHub Secrets for CI/CD

### Zone Already Exists
If zones already exist in Cloudflare, import them:
```bash
terraform import cloudflare_zone.autolife_ai <zone-id>
```

### State Lock
If using Terraform Cloud and state is locked:
1. Go to the run in Terraform Cloud
2. Cancel the run or unlock manually