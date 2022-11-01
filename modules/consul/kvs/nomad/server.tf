###
# Nomad Server Config
###

resource "consul_key_prefix" "server_config" {
  datacenter = var.consul_datacenter

  path_prefix = "nomad/server/config/"

  subkeys = {
    "region"     = "us-east1"
    "data_dir"   = "/opt/nomad/data"
    "datacenter" = "dev-us-east1"

    # ACL
    "acl/enabled" = true

    "audit/enabled"                      = true
    "audit/sink/json/delivery_guarantee" = "enforced",
    "audit/sink/json/format"             = "json"
    "audit/sink/json/mode"               = "0600"
    "audit/sink/json/path"               = "/opt/nomad/audit/audit.log"
    "audit/sink/json/rotate_bytes"       = 100
    "audit/sink/json/rotate_duration"    = "24h"
    "audit/sink/json/rotate_max_files"   = 10
    "audit/sink/json/type"               = "file"

    # Server
    "server/enabled"          = true
    "server/bootstrap_expect" = 3
    "server/license_path"     = "/opt/nomad/license/nomad.lic"

    # TLS
    "tls/rpc"                    = true
    "tls/http"                   = true
    "tls/ca_file"                = "/opt/nomad/tls/nomad-ca.pem"
    "tls/key_file"               = "/opt/nomad/tls/nomad-key.pem"
    "tls/cert_file"              = "/opt/nomad/tls/nomad-cert.pem"
    "tls/verify_server_hostname" = true

    # Vault
    "vault/enabled"          = true
    "vault/address"          = "https://vault-addr"
    "vault/create_from_role" = "nomad-cluster"
  }
}
