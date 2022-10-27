#!/bin/bash

# SOURCE ME
export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="vault-root-dev"
echo "Disabling default kv engine mounted at /secret in order to create this with Terraform"
vault secrets disable secret

export CONSUL_HTTP_ADDR="http://127.0.0.1:8500"
export CONSUL_HTTP_TOKEN="8bf72d90-f845-4e45-bb7b-a5f73367cb77"

# Nomad does not allow for seeding an initial token, so...
# sourcing this file will bootstraps its ACLs and export the management token to your local shell
echo "Bootstrapping Nomad Server's ACLs. This will FAIL if the Nomad development server is not running."
export NOMAD_ADDR="http://127.0.0.1:4646"
export NOMAD_TOKEN="$(nomad acl bootstrap -t '{{ .SecretID }}')"

# For consumption by Terraform
export TF_VAR_vault_token="${VAULT_TOKEN}"
export TF_VAR_consul_token="${CONSUL_HTTP_TOKEN}"
export TF_VAR_nomad_token="${NOMAD_TOKEN}"
