###
# secrets-config.hcl
# This is a consul-template config for fetching existing secrets, generating secret tokens, and generating TLS certificates from Vault
###

# Authenticates with environment variables, CONSUL_HTTP_ADDR and CONSUL_TOKEN
consul {}

# Authenticates with environment variables, VAULT_ADDR and VAULT_TOKEN
vault {
  # Required for running consul-template with -once for local development
  renew_token = false
}

###
# Encrypt
###
# Generate Consul Encryption Key
template {
  contents    = "encrypt = \"{{ with secret \"secret/consul/agent/config\" }}{{ .Data.data.encrypt }}{{ end }}\""
  destination = "./configs/generated/consul/encrypt.hcl"
  perms       = 0600
}

# Generates a Consul token, through Vault's 'Consul secret engine'
template {
  contents    = <<EOT
  tokens = {
    default = "{{ with secret "consul/creds/kv-read" }}{{ .Data.token }}{{ end }}"
  }
EOT
  destination = "./configs/generated/consul/acl.hcl"
  perms       = 0600
}

###
# PKI Templates
###
# The following 4 template {} blocks will make a single API call to Vault in order to generate a certificate
# For more information on this process, see: https://github.com/hashicorp/consul-template/blob/main/examples/vault-pki.md#multiple-output-files
template {
  source      = "./configs/templates/tls/nomad-cert.pem.tpl"
  destination = "./configs/generated/tls/nomad-cert.pem"
  perms       = 0600
}

template {
  source      = "./configs/templates/tls/nomad-key.pem.tpl"
  destination = "./configs/generated/tls/nomad-key.pem"
  perms       = 0600
}

template {
  source      = "./configs/templates/tls/nomad-ca.pem.tpl"
  destination = "./configs/generated/tls/nomad-ca.pem"
  perms       = 0600
}

template {
  source      = "./configs/templates/tls/consul-ca.pem.tpl"
  destination = "./configs/generated/tls/consul-ca.pem"
  perms       = 0600
}