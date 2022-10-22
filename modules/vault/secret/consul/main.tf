# Intended to be used for local development
resource "vault_consul_secret_backend" "config" {
  path        = "consul"
  description = "Consul secret backend"
  address     = "http://127.0.0.1:8500"
  token       = var.consul_token
}
