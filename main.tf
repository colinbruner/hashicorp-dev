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
  source = "./modules/vault"

  # Consul
  consul_token   = var.consul_token
  consul_license = var.consul_license
  # Nomad
  nomad_token   = var.nomad_token
  nomad_license = var.nomad_license
  # Monitoring
  monitoring_apikeys = local.monitoring_apikeys
}

module "consul" {
  source = "./modules/consul"

  region = var.region
}

module "nomad" {
  source = "./modules/nomad"
}
