###
# nomad-config.hcl
# Generates Consul k/v's into a JSON file for consumption by Nomad agents
###

# Authenticates with environment variables, CONSUL_HTTP_ADDR and CONSUL_TOKEN
consul {}

# Authenticates with environment variables, VAULT_ADDR and VAULT_TOKEN
vault {
  # Required for running consul-template with -once for local development
  renew_token = false
}

template {
  source      = "./configs/templates/nomad/encrypt.hcl.tpl"
  destination = "./configs/generated/nomad/encrypt.hcl"
  perms       = 0600
}

template {
  source      = "./configs/templates/nomad/nomad.env.tpl"
  destination = "./configs/generated/nomad/nomad.env"
  perms       = 0600
}

template {
  source      = "./configs/templates/nomad/nomad.json.tpl"
  destination = "./configs/generated/nomad/nomad.json"
  perms       = 0600
}
