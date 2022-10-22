resource "random_id" "consul_gossip_encryption_key" {
  byte_length = 32
}

resource "random_id" "nomad_gossip_encryption_key" {
  byte_length = 32
}

resource "vault_kv_secret_v2" "consul_agent_config_idig" {
  mount = vault_mount.kvv2.path
  name  = "consul/agent/config"

  data_json = jsonencode(
    {
      encrypt = random_id.consul_gossip_encryption_key.b64_std
    }
  )
}

resource "vault_kv_secret_v2" "nomad_server_config" {
  mount = vault_mount.kvv2.path
  name  = "nomad/server/config"

  data_json = jsonencode({
    encrypt = random_id.nomad_gossip_encryption_key.b64_std
  })
}

resource "vault_kv_secret_v2" "hashicorp" {
  mount = vault_mount.kvv2.path
  name  = "hashicorp/licenses"

  data_json = jsonencode({
    nomad  = var.nomad_license
    consul = var.consul_license
  })
}
