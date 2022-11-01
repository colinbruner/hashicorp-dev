resource "vault_nomad_secret_role" "management" {
  backend = vault_nomad_secret_backend.config.backend
  role    = "management"
  type    = "management"
}

resource "vault_nomad_secret_role" "readonly" {
  backend  = vault_nomad_secret_backend.config.backend
  role     = "readonly"
  type     = "client"
  policies = ["readonly"]
}

resource "vault_nomad_secret_role" "nomad_client_drain" {
  backend  = vault_nomad_secret_backend.config.backend
  role     = "nomad-client-drain"
  type     = "client"
  policies = ["nomad-client-drain"]
}
