###
# Nomad
###
variable "nomad_token" {
  type      = string
  sensitive = true
}

variable "nomad_license" {
  type      = string
  sensitive = true
}

variable "nomad_enabled" {
  type        = bool
  default     = true
  description = "Configure Nomad through Terraform"
}

###
# Consul
###
variable "consul_token" {
  type      = string
  sensitive = true
}

variable "consul_license" {
  type      = string
  sensitive = true
}

variable "consul_enabled" {
  default     = true
  description = "Configure Consul through Terraform"
}

###
# Misc
###
variable "monitoring_apikeys" {
  type      = map(string)
  sensitive = true
}

variable "vault_database_secrets_enabled" {
  type        = bool
  default     = false
  description = "Boolean to enable database secrets engine, requires postgresql to be running locally on 5432. View README.md for more information."
}
