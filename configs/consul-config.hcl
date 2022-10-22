###
# nomad-config.hcl
# Generates Consul k/v's into a hcl file for consumption by Consul agents
###

# Authenticates with environment variables, CONSUL_HTTP_ADDR and CONSUL_TOKEN
consul {}

# Authenticates with environment variables, VAULT_ADDR and VAULT_TOKEN
vault {
  # Required for running consul-template with -once for local development
  renew_token = false
}

###
# Templates
###

# Consul Config, demonstrates modifying a specific templates delimiters to avoid symbol conflicts
template {
  source          = "./configs/templates/consul/consul.hcl.tpl"
  destination     = "./configs/generated/consul/consul.hcl"
  perms           = 0600
  left_delimiter  = "[["
  right_delimiter = "]]"
}
