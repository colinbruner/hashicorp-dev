module "consul" {
  source = "./secret/consul"

  consul_token = var.consul_token
}

module "nomad" {
  source = "./secret/nomad"

  nomad_token = var.nomad_token
}

module "pki" {
  source = "./secret/pki"
}

module "database" {
  count  = var.vault_database_secrets_enabled ? 1 : 0
  source = "./secret/database"
}

module "policy" {
  source = "./policy"
}

module "roles" {
  source = "./roles"

  # Backends
  auth_backend_approle_path = vault_auth_backend.approle.path
  # Policies
  policy = module.policy
}
