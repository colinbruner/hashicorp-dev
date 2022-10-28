variable "nomad_token" {
  type      = string
  sensitive = true
}

variable "nomad_license" {
  type      = string
  sensitive = true
}

variable "consul_token" {
  type      = string
  sensitive = true
}

variable "consul_license" {
  type      = string
  sensitive = true
}

variable "monitoring_apikeys" {
  type      = map(string)
  sensitive = true
}
