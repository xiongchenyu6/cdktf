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

variable "tcloud_sh_ip" {
  description = "Tencent Cloud Shanghai server IP (tcloud-sh)"
  type        = string
  default     = "43.139.62.96"
}

variable "game_ip" {
  description = "Game server IP (game)"
  type        = string
  default     = "172.22.240.99"
}

variable "gz_office_ip" {
  description = "Guangzhou office server IP (gz-office, port 2222, user autolife)"
  type        = string
  default     = "112.94.11.147"
}

variable "lubancat_ip" {
  description = "Lubancat server IP (lubancat, user root)"
  type        = string
  default     = "203.116.95.146"
}

variable "office_ip" {
  description = "Office server IP (office)"
  type        = string
  default     = "172.22.240.98"
}

variable "sg_office_ip" {
  description = "Singapore office server IP (sg-office)"
  type        = string
  default     = "101.78.126.6"
}

variable "sz_office_ip" {
  description = "Shenzhen office server IP (sz-office, port 2222, user autolife)"
  type        = string
  default     = "113.90.155.31"
}
