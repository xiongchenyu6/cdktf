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

# Oracle Cloud Infrastructure servers
variable "oracle_amd_001_ip" {
  description = "Oracle AMD 001 server IP (oracle-amd-001)"
  type        = string
  default     = "213.35.97.233"
}

variable "oracle_amd_002_ip" {
  description = "Oracle AMD 002 server IP (oracle-amd-002)"
  type        = string
  default     = "213.35.117.232"
}

variable "oracle_arm_001_ip" {
  description = "Oracle ARM 001 server IP (oracle-arm-001)"
  type        = string
  default     = "138.2.95.174"
}

variable "oracle_arm_002_ip" {
  description = "Oracle ARM 002 server IP (oracle-arm-002)"
  type        = string
  default     = "138.2.76.211"
}

variable "tcloud_ip" {
  description = "Tencent Cloud server IP (tcloud)"
  type        = string
  default     = "43.156.66.157"
}