###
# testing-config.hcl
###

# Authenticates with environment variables, CONSUL_HTTP_ADDR and CONSUL_TOKEN
consul {}

# Authenticates with environment variables, VAULT_ADDR and VAULT_TOKEN
vault {
  # Required for running consul-template with -once for local development
  renew_token = false
}

template {
  contents    = "{{ tree (print \"config/testing\") | explode | toJSONPretty }}"
  destination = "./configs/generated/config/testing.json"
  perms       = 0600
}

template {
  contents    = "{{ tree (print \"config/testing\") | explode | toYAML }}"
  destination = "./configs/generated/config/testing.yaml"
  perms       = 0600
}

template {
  contents    = "{{ tree (print \"config/testing\") | explode | toTOML }}"
  destination = "./configs/generated/config/testing.toml"
  perms       = 0600
}
