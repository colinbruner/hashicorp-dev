#!/bin/bash


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# Execute
CMD="consul"
BASE_ARGS="agent -dev -config-file=${SCRIPT_DIR}/configs/consul/secrets.json -config-file=${SCRIPT_DIR}/configs/consul/config.hcl"

if [[ $1 == "debug" ]]; then
  CMD=$(echo "${CMD} -log-level='debug'")
fi

# If 'CONSUL_LICENSE' environment variable is not empty, set the command to 'consul-ent'
# NOTE: This expects a consul enterprise binary present in your local PATH named 'consul-ent'
if [[ ! -z ${CONSUL_LICENSE} ]]; then
  CMD="consul-ent"
fi

# Starts Consul server in dev mode with ACLs enabled
echo "${CMD} ${BASE_ARGS}"
${CMD} ${BASE_ARGS} -client '{{ GetPrivateInterfaces | exclude "type" "ipv6" | join "address" " " }} 127.0.0.1'
