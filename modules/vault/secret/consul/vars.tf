variable "consul_token" {
  type        = string
  sensitive   = true
  description = "Consul bootstrap token for configing Consul secrets engine"
}
