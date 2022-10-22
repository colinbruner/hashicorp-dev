resource "consul_key_prefix" "consul" {
  datacenter = var.consul_datacenter

  path_prefix = "consul/agent/config/"

  subkeys = {
    "auto_join_address" = "192.168.1.10"

    "data_dir"     = "/opt/consul/data"
    "datacenter"   = var.consul_datacenter
    "license_path" = "/opt/consul/license/consul.lic"

    "acl/enabled"                  = true
    "acl/default_policy"           = "deny"
    "acl/enable_token_persistence" = true

    "ports/grpc" = "8502"

    "tls/defaults/ca_file"                    = "/opt/consul/tls/consul-ca.pem"
    "tls/defaults/verify_incoming"            = false
    "tls/defaults/verify_outgoing"            = true
    "tls/internal_rpc/verify_server_hostname" = true
  }
}
