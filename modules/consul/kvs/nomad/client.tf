###
# Nomad Client
# Contains base configuration intended to be applied to all Nomad Clients
# NOTE: For client pool specific configuration, see nomad-client-pools.tf
###
resource "consul_key_prefix" "client_config" {
  datacenter = var.consul_datacenter

  path_prefix = "nomad/client/config/"

  subkeys = {
    "region"   = var.region
    "data_dir" = "/opt/nomad/data"

    # ACL
    "acl/enabled" = true

    # Server
    "server/license_path" = "/opt/nomad/license/nomad.lic"

    # TLS
    "tls/rpc"                    = true
    "tls/http"                   = true
    "tls/ca_file"                = "/opt/nomad/tls/nomad-ca.pem"
    "tls/key_file"               = "/opt/nomad/tls/nomad-key.pem"
    "tls/cert_file"              = "/opt/nomad/tls/nomad-cert.pem"
    "tls/verify_server_hostname" = true

    # Vault
    "vault/enabled" = true
    "vault/address" = "https://vault-addr"

    "plugin/docker/config/allow_privileged" = true
    "plugin/docker/config/logging/type"     = "journald"
  }
}
