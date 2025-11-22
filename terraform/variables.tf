variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = "2764ae0fd9a5cb92c9ac67708620e54c"
}

variable "home_ip" {
  description = "Home server IP address"
  type        = string
  default     = "138.2.95.174"
}

variable "kanidm_ip" {
  description = "Kanidm server IP address"
  type        = string
  default     = "213.35.97.233"
}