#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Execute
CMD="vault"
ARGS="server -config=${SCRIPT_DIR}/configs/vault-consul-registration.hcl -dev -dev-root-token-id=vault-root-dev"

if [[ $1 == "debug" ]]; then
  export VAULT_LOG_LEVEL="DEBUG"
fi

# If 'VAULT_LICENSE' environment variable is not empty, set the command to 'vault-ent'
# NOTE: This expects a Vault enterprise binary present in your local PATH named 'vault-ent'
if [[ ! -z ${VAULT_LICENSE} ]]; then
  CMD="vault-ent"
fi

# Starts Vault server in dev mode with set root token
echo "${CMD} ${ARGS}"
${CMD} ${ARGS}