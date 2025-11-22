# Import existing DNS records
# This file handles importing existing DNS records from Cloudflare
# After successful import, this file can be removed

# To use this file:
# 1. Uncomment the import blocks for records that already exist
# 2. Run terraform plan
# 3. Run terraform apply
# 4. After successful import, you can delete this file

# Import format: import { to = resource_type.resource_name, id = "zone_id/record_id" }
# To find record IDs, use: curl -X GET "https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records" -H "Authorization: Bearer YOUR_API_TOKEN"

# Uncomment the imports below as needed:

# import {
#   to = cloudflare_record.www
#   id = "${cloudflare_zone.autolife_ai.id}/RECORD_ID_HERE"
# }

# import {
#   to = cloudflare_record.api
#   id = "${cloudflare_zone.autolife_ai.id}/RECORD_ID_HERE"
# }

# import {
#   to = cloudflare_record.mainpage
#   id = "${cloudflare_zone.autolife_ai.id}/RECORD_ID_HERE"
# }

# Add more import blocks as needed for other existing records