# Intended to be used for local development
resource "vault_nomad_secret_backend" "config" {
  backend     = "nomad"
  description = "Nomad secret backend"
  address     = "http://127.0.0.1:4646"
  token       = var.nomad_token
}
