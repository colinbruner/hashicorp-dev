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

###
# Environment
###
variable "environment" {
  default = "dev"
}
variable "region" {
  default = "us-east1"
}
