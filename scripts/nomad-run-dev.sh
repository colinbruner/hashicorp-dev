#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Execute
CMD="nomad"
ARGS="agent -dev -config=${SCRIPT_DIR}/configs/nomad/ -acl-enabled -consul-token=$(cat ${SCRIPT_DIR}/configs/shared/consul-dev.token)"

if [[ $1 == "debug" ]]; then
  CMD=$(echo "${CMD} -log-level='debug'")
fi

# If 'NOMAD_LICENSE' environment variable is not empty, set the command to 'nomad-ent'
# NOTE: This expects a nomad enterprise binary present in your local PATH named 'nomad-ent'
if [[ ! -z ${NOMAD_LICENSE} ]]; then
  CMD="nomad-ent"
fi

# Starts Nomad server in dev mode
echo "${CMD} ${ARGS}"
${CMD} ${ARGS}
