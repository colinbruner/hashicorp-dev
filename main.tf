locals {
  # Contrived 'api-keys' to pass to vault for secrets variables
  monitoring_apikeys = {
    platform   = "secret-platform"
    dev        = "secret-dev"
    staging    = "secret-staging"
    production = "secret-production"
  }
}

module "vault" {
  count = var.vault_enabled ? 1 : 0

  source = "./modules/vault"

  # Consul
  consul_token   = var.consul_token
  consul_license = var.consul_license
  consul_enabled = var.consul_enabled
  # Nomad
  nomad_token   = var.nomad_token
  nomad_license = var.nomad_license
  nomad_enabled = var.nomad_enabled
  # Monitoring
  monitoring_apikeys = local.monitoring_apikeys
}

module "consul" {
  count  = var.consul_enabled ? 1 : 0
  source = "./modules/consul"

  region = var.region
}

module "nomad" {
  count  = var.nomad_enabled ? 1 : 0
  source = "./modules/nomad"
}
