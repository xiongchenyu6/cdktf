#!/bin/bash

# Migration script from CDKTF to pure Terraform

echo "==================================="
echo "CDKTF to Terraform Migration Script"
echo "==================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running from repo root
if [ ! -f "package.json" ]; then
    echo -e "${RED}Error: Please run this script from the repository root${NC}"
    exit 1
fi

echo -e "${YELLOW}This script will help you migrate from CDKTF to pure Terraform${NC}"
echo ""
echo "Choose an option:"
echo "1) Clean migration (destroy CDKTF resources, then create with Terraform)"
echo "2) Import migration (keep existing resources, import to Terraform)"
echo "3) Just setup Terraform (no migration)"
echo ""
read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        echo -e "${YELLOW}Clean Migration Selected${NC}"
        echo ""

        # Destroy CDKTF resources
        echo "First, we need to destroy existing CDKTF resources..."
        echo "This will DELETE all your Cloudflare zones and DNS records!"
        read -p "Are you sure you want to continue? (yes/no): " confirm

        if [ "$confirm" = "yes" ]; then
            echo "Running cdktf destroy..."
            if command -v cdktf &> /dev/null; then
                cdktf destroy --auto-approve
            else
                npx cdktf destroy --auto-approve
            fi

            echo -e "${GREEN}CDKTF resources destroyed${NC}"

            # Setup Terraform
            cd terraform
            echo "Initializing Terraform..."
            terraform init

            echo "Applying Terraform configuration..."
            terraform apply

            echo -e "${GREEN}Migration complete!${NC}"
        else
            echo "Migration cancelled"
            exit 0
        fi
        ;;

    2)
        echo -e "${YELLOW}Import Migration Selected${NC}"
        echo ""
        echo "This will import existing resources to Terraform state"
        echo ""

        cd terraform

        # Initialize Terraform
        echo "Initializing Terraform..."
        terraform init

        # Get zone IDs from CDKTF state
        echo "Getting existing resource IDs..."
        cd ../cdktf.out/stacks/cdktf

        if [ -f ".terraform/terraform.tfstate" ]; then
            echo "Found local state file"
            # Extract zone IDs
            AUTOLIFE_AI_ID=$(terraform state show cloudflare_zone.autolife-ai 2>/dev/null | grep "id" | awk '{print $3}' | tr -d '"')
            AUTOLIFE_DPDNS_ID=$(terraform state show cloudflare_zone.autolifedpdnsorg 2>/dev/null | grep "id" | awk '{print $3}' | tr -d '"')
            XIONGCHENYU_DPDNS_ID=$(terraform state show cloudflare_zone.xiongchenyudpdnsorg 2>/dev/null | grep "id" | awk '{print $3}' | tr -d '"')
        else
            echo -e "${YELLOW}No local state found. Please enter zone IDs manually${NC}"
            echo "You can find these in your Cloudflare dashboard"
            read -p "Enter autolife.ai zone ID: " AUTOLIFE_AI_ID
            read -p "Enter autolife.dpdns.org zone ID: " AUTOLIFE_DPDNS_ID
            read -p "Enter xiongchenyu.dpdns.org zone ID: " XIONGCHENYU_DPDNS_ID
        fi

        cd ../../../terraform

        # Import zones
        if [ ! -z "$AUTOLIFE_AI_ID" ]; then
            echo "Importing autolife.ai zone..."
            terraform import cloudflare_zone.autolife_ai "$AUTOLIFE_AI_ID"
        fi

        if [ ! -z "$AUTOLIFE_DPDNS_ID" ]; then
            echo "Importing autolife.dpdns.org zone..."
            terraform import cloudflare_zone.autolife_dpdns_org "$AUTOLIFE_DPDNS_ID"
        fi

        if [ ! -z "$XIONGCHENYU_DPDNS_ID" ]; then
            echo "Importing xiongchenyu.dpdns.org zone..."
            terraform import cloudflare_zone.xiongchenyu_dpdns_org "$XIONGCHENYU_DPDNS_ID"
        fi

        echo ""
        echo -e "${YELLOW}Note: DNS records will be recreated. Run 'terraform plan' to review changes${NC}"
        terraform plan

        echo ""
        echo -e "${GREEN}Import complete! Run 'terraform apply' when ready${NC}"
        ;;

    3)
        echo -e "${YELLOW}Setting up Terraform (no migration)${NC}"
        echo ""

        cd terraform

        # Copy tfvars example
        if [ ! -f "terraform.tfvars" ]; then
            echo "Creating terraform.tfvars from example..."
            cp terraform.tfvars.example terraform.tfvars
            echo -e "${YELLOW}Please edit terraform/terraform.tfvars with your Cloudflare API token${NC}"
        fi

        # Initialize
        echo "Initializing Terraform..."
        terraform init

        echo -e "${GREEN}Setup complete!${NC}"
        echo ""
        echo "Next steps:"
        echo "1. Edit terraform/terraform.tfvars with your Cloudflare API token"
        echo "2. Run 'cd terraform && terraform plan' to review changes"
        echo "3. Run 'terraform apply' to create resources"
        ;;

    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo "==================================="
echo "For more information, see terraform/README.md"