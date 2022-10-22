# Main
data_dir     = "[[ key "consul/agent/config/data_dir" ]]"
datacenter   = "[[ key "consul/agent/config/datacenter" ]]"
license_path = "[[ key "consul/agent/config/license_path" ]]"

# Addresses
bind_addr   = "{{ GetPrivateInterfaces | include \"network\" \"192.168.1.0/24\" | attr \"address\" }}"
client_addr = "{{ GetPrivateInterfaces | join \"address\" \" \" }} {{ GetAllInterfaces | include \"flags\" \"loopback\" | join \"address\" \" \" }}"

ports {
  grpc = 8502
}

# Logging
log_json  = [[ keyOrDefault "consul/agent/config/log_json" "true" | parseBool ]]
log_level = "[[ keyOrDefault "consul/agent/config/log_level" "info" ]]"

# ACLs
[[ if key "consul/agent/config/acl/enabled" | parseBool ]]
acl = {
  enabled                  = true
  default_policy           = "[[ key "consul/agent/config/acl/default_policy" ]]"
  enable_token_persistence = "[[ key "consul/agent/config/acl/enable_token_persistence" ]]"
  tokens = {
    # NOTE: Token not appropriate for actual consul config, demonstration purposes only
    default = "[[ with secret "consul/creds/kv-read" ]][[ .Data.token ]][[ end ]]"
  }
}
[[ end ]]

auto_encrypt = {
  tls = true
}

[[ if keyOrDefault "consul/agent/config/connect/enabled" "true" | parseBool ]]
connect = {
  enabled = true
}
[[ end ]]

tls {
  defaults {
    ca_file                = "[[ keyOrDefault "consul/agent/config/tls/defaults/ca_file" "/opt/consul/tls/consul-ca.pem" ]]"
    verify_incoming        = [[ keyOrDefault "consul/agent/config/tls/defaults/verify_incoming" "false" | parseBool ]]
    verify_outgoing        = [[ keyOrDefault "consul/agent/config/tls/defaults/verify_outgoing" "true" | parseBool ]]
  }
  internal_rpc {
    verify_server_hostname = [[ keyOrDefault "consul/agent/config/tls/internal_rpc/verify_server_hostname" "true" | parseBool ]]
  }
}