###
# Nomad Client Pools
# Contains Nomad Client Pool specific configurations 
# The path prefix should follow a 'nomad/client/<node_class>/config' schema
###

resource "consul_key_prefix" "client_compute" {
  datacenter = var.consul_datacenter

  path_prefix = "nomad/client/class/compute/config/"
  subkeys = {
    # These keys are expected under Nomad's client {} stanza
    "client/node_class"       = "compute"
    "client/meta/owner"       = "platform"
    "client/meta/environment" = var.environment
    "client/meta/app_pool"    = "true"
  }
}

resource "consul_key_prefix" "client_ingress" {
  datacenter = var.consul_datacenter

  path_prefix = "nomad/client/class/ingress/config/"
  subkeys = {
    # These keys are expected under Nomad's client {} stanza
    "client/node_class"       = "ingress"
    "client/meta/owner"       = "platform"
    "client/meta/environment" = var.environment
    "client/meta/app_pool"    = "false"
  }
}

resource "consul_key_prefix" "client_gpu" {
  datacenter = var.consul_datacenter

  path_prefix = "nomad/client/class/gpu/config/"
  subkeys = {
    # These keys are expected under Nomad's client {} stanza
    "client/node_class"       = "gpu"
    "client/meta/owner"       = "platform"
    "client/meta/environment" = var.environment
    "client/meta/app_pool"    = "true"
  }
}

