variable "nomad_token" {
  type        = string
  sensitive   = true
  description = "Nomad bootstrap token for configing Nomad secrets engine"
}
