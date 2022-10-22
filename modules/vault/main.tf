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
