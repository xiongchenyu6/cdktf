variable "cloudflare_api_token" {
  description = "Cloudflare API Token (needs DNS edit + zone create permissions)"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID that owns panda.qzz.io"
  type        = string
  default     = "2764ae0fd9a5cb92c9ac67708620e54c"
}

# Hurricane Electric DNS (dns.he.net) login — set as sensitive vars in the
# Terraform Cloud workspace. The provider logs into the HE web UI; there is no
# API token. No 2FA -> store_type = "dummy" (no cookie persisted).
variable "he_username" {
  description = "Hurricane Electric (dns.he.net) account username"
  type        = string
  sensitive   = true
}

variable "he_password" {
  description = "Hurricane Electric (dns.he.net) account password"
  type        = string
  sensitive   = true
}

# Server IPs referenced by DNS records
variable "oracle_amd_002_ip" {
  description = "Oracle AMD 002 server IP (oracle-amd-002)"
  type        = string
  default     = "213.35.117.232"
}

variable "oracle_arm_002_ip" {
  description = "Oracle ARM 002 server IP (oracle-arm-002)"
  type        = string
  default     = "138.2.76.211"
}

variable "gz_office_ip" {
  description = "Guangzhou office server IP (gz-office, port 2222, user autolife)"
  type        = string
  default     = "112.94.11.147"
}
