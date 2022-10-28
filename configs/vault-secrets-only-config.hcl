###
# vault-secret-only-config.hcl
# This is a consul-template config for fetching secret from Vault, and not interacting with Consul at all
###

# Authenticates with environment variables, CONSUL_HTTP_ADDR and CONSUL_TOKEN
#consul {}

# Authenticates with environment variables, VAULT_ADDR and VAULT_TOKEN
vault {
  # Required for running consul-template with -once for local development
  renew_token = false
}

###
# API Keys
###
# Generate Platform
template {
  contents    = "api-key = \"{{ with secret \"secret/monitoring/apikeys\" }}{{ .Data.data.platform }}{{ end }}\""
  destination = "./configs/generated/monitoring/platform-api-keys.hcl"
  perms       = 0600
}
# Generate Dev
template {
  contents    = "api-key = \"{{ with secret \"secret/monitoring/apikeys\" }}{{ .Data.data.dev }}{{ end }}\""
  destination = "./configs/generated/monitoring/dev-api-keys.hcl"
  perms       = 0600
}

# Generate Staging
template {
  contents    = "api-key = \"{{ with secret \"secret/monitoring/apikeys\" }}{{ .Data.data.staging }}{{ end }}\""
  destination = "./configs/generated/monitoring/staging-api-keys.hcl"
  perms       = 0600
}

# Generate Production
template {
  contents    = "api-key = \"{{ with secret \"secret/monitoring/apikeys\" }}{{ .Data.data.production }}{{ end }}\""
  destination = "./configs/generated/monitoring/production-api-keys.hcl"
  perms       = 0600
}
