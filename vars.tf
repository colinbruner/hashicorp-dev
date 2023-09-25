###
# Vault
###
variable "vault_enabled" {
  default     = true
  description = "Configure Vault through Terraform"
}

###
# Consul
###
variable "consul_token" {
  type      = string
  sensitive = true
}

variable "consul_license" {
  description = "Optional Enterprise Consul License"
  default     = ""
}

variable "consul_enabled" {
  default     = true
  description = "Configure Consul through Terraform"
}

###
# Nomad
###
variable "nomad_token" {
  type      = string
  sensitive = true
}

variable "nomad_license" {
  description = "Optional Enterprise Nomad License"
  default     = ""
}

variable "nomad_enabled" {
  type        = bool
  default     = true
  description = "Configure Nomad through Terraform"
}

###
# Environment
###
variable "environment" {
  default = "dev"
}
variable "region" {
  default = "us-east1"
}
