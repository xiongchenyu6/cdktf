#!/bin/bash
# Script to remove invalid resources from Terraform state

echo "This script will remove invalid resources from Terraform Cloud state"
echo "Run this in the cdktf.out/stacks/cdktf directory"
echo ""

cd cdktf.out/stacks/cdktf || exit 1

# Remove the invalid zones and their DNS records
echo "Removing invalid resources from state..."

# Remove invalid zones
terraform state rm cloudflare_zone.autolife-tech 2>/dev/null || true
terraform state rm cloudflare_zone.sexyqzzio 2>/dev/null || true

# Remove DNS records that reference invalid zones
terraform state rm cloudflare_dns_record.ollama 2>/dev/null || true

# List remaining resources
echo ""
echo "Remaining resources in state:"
terraform state list

echo ""
echo "Now run: terraform plan"
echo "This should recreate the resources with correct configuration"