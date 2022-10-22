module "consul-kvs" {
  source = "./kvs/consul"

  consul_datacenter = "dc1"
}

module "nomad-kvs" {
  source = "./kvs/nomad"

  consul_datacenter = "dc1"
  region            = var.region
}
