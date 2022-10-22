resource "vault_consul_secret_backend_role" "readonly" {
  name    = "readonly"
  backend = vault_consul_secret_backend.config.path

  policies = [
    "readonly"
  ]
}

resource "vault_consul_secret_backend_role" "nomad_snapshot_agent" {
  name    = "nomad-snapshot-agent"
  backend = vault_consul_secret_backend.config.path

  consul_roles = [
    "nomad-snapshot-agent"
  ]
}

resource "vault_consul_secret_backend_role" "kv_admin" {
  name    = "kv-read"
  backend = vault_consul_secret_backend.config.path

  consul_roles = [
    "kv-read",
  ]
}
