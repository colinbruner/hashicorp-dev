module "vault" {
  source = "./modules/vault"

  # Consul
  consul_token   = var.consul_token
  consul_license = var.consul_license
  # Nomad
  nomad_token   = var.nomad_token
  nomad_license = var.nomad_license
}

module "consul" {
  source = "./modules/consul"

  region = var.region
}

module "nomad" {
  source = "./modules/nomad"
}
