# hashicorp-dev

Local development setup for Terraform, Vault, Consul, Nomad, and consul-template

## Pre-requisites

This README assumes Terraform, Vault, Consul, Nomad, and consul-template are installed locally, as well as basic understanding of Hashicorp products and the CLI.

## Features

- Quick and easy local development environment
- Access to Vault PKI engine for local certificate generation and testing
- Access to Vault kv Secret engine for familiarity with Vault secrets and secret templating
- Access to Consul kv's for usage with consul-template to generate configuration files
- Access to Vault, Consul, and Nomad ACLs for policy and role generation and experimentation
- Optional Hashicorp 'enterprise' dev mode settings
- Example consul-template configuration files in [configs](./configs) directory
- Examples using consul-template in [consul-template](#consul-template) section.

## Setup

Start Vault, Consul, and Nomad in local dev mode with the following scripts.

```bash
# Creates local Vault dev instances, registers service with Consul
./scripts/vault-run-dev.sh
# Creates local Consul dev instance with ACLs enabled
./scripts/consul-run-dev.sh
# Creates local Nomad dev instance, registers service with Consul
./scripts/nomad-run-dev.sh
```

### Authentication

Vault and Consul allow a pre-seeded or provided "root token" or "management token" for accessing them while their ACLs are enabled, however Nomad does not. Sourcing the following script will:

- Set Environment Variables for Vault authentication
- Set Environment Variables for Consul authentication
- Set Environment Variables for Nomad authentication, as well as boostrap Nomad's ACLs

```bash
# Source secrets to your local shell
source scripts/export-secrets.sh
```

NOTE: Once Nomad's ACLs are initially bootstrapped, Nomad will not allow for them to be bootstrapped again. You will need to stop the locally running Nomad dev agent and start it up again to enable ACLs to be re-bootstrapped.

#### Verify

Verify two sets of tokens are present. The first is used by Terraform for initial provider authentication and configuration. The second is used as input variables for Terraform modules to configure aspects of Vault, such as Nomad / Consul secret engines.

```bash
# Verify VAULT_ADDR, VAULT_TOKEN, CONSUL_ADDR, CONSUL_TOKEN, NOMAD_ADDR, and NOMAD_TOKEN are set properly.
env | grep -E '(VAULT|CONSUL|NOMAD)'
# Verify TF_VAR_consul_token, TF_VAR_nomad
nv | grep -E '(consul|nomad)'
```

### Terraform

Once your have Vault, Consul, and Nomad dev instances running locally and secrets exported into your shell, you're good to configure them using Terraform.

Before running `terraform apply` review [enabled.auto.tfvars](./enabled.auto.tfvars) to ensure you're applying configurations for services you're developing.

```bash
terraform apply
...
Apply complete! Resources: 30 added, 0 changed, 0 destroyed.
```

For more information on how exactly Terraform is configuring these systems, check out [main.tf](./main.tf) and subsequent modules being called under the [modules/](./modules/) directory.

## consul-template

consul-template is a powerful tool to interact with Vault and Consul to generate secrets or configuration k/v's from both sources. It uses Golang [templates][templates] with some additional filters viewable from [consul-templates language][ct-lang].

### Examples

All examples are intended to be run from the root directory of this repo.

#### Secrets

The following will generate secret values for Consul configuration, acl.hcl and encrypt.hcl within [configs/generated/consul/](./configs/generated/consul/). Additionally, we'll also generate TLS certificates signed by Vault's intermediate CA at [configs/generated/tls/](./configs/generated/tls/)

```bash
consul-template -once -config configs/secrets-config.hcl
```

#### Configs

The following will generate contrived configuration values for running Nomad or Consul agents.

```bash
consul-template -once -config configs/nomad-config.hcl
consul-template -once -config configs/consul-config.hcl
```

#### Vault Approle

The following are some example to work with Vault approle

```bash
# Verify approle is enabled and mounted
vault auth list

# List configured approles
vault list auth/approle/role

# Read Approle 'role_id'
vault read auth/approle/role/approle-manager/role-id

# Generate Approle 'secret_id'
vault write -f auth/approle/role/approle-manager/secret-id

# Login to Approle to generate a Vault token
vault write auth/approle/login role_id="<role-id>" secret_id="<secret-id>"
```

#### Dynamic Database Secrets

The follow replicates the Hashicorp tutorial found [here](https://developer.hashicorp.com/vault/tutorials/db-credentials/database-secrets).

This assumes the following commands have been executed locally.

```bash
# This should mimic steps 1-5 within the 'Start Postgres' section of the tutorial linked above
$ ./scripts/database/setup-postgres.sh
```

Once the following is setup locally, a Terraform apply will allow you to create dynamic secrets.

```bash
$ terraform apply -var "vault_database_secrets_enabled=true"
```

Generate Postgres credentials with the following:

```bash
$ vault read database/creds/readonly
Key                Value
---                -----
lease_id           database/creds/readonly/80MYLLuuMhn0qLG9ZDV2nral
lease_duration     1h
lease_renewable    true
password           GTMd-UiySaplF1dWlpxb
username           v-token-readonly-LQpd4b1NekmYV4H3GsHh-1668720276
```

View Postgres users with the following:

```bash
$ ./scripts/database/view-postgers-users.sh
                     usename                      |        valuntil
--------------------------------------------------+------------------------
 root                                             |
 v-token-readonly-LQpd4b1NekmYV4H3GsHh-1668720276 | 2022-11-17 22:34:35+00
```

View the existing database leases within Vault

```bash
$ vault list sys/leases/lookup/database/creds/readonly
Keys
----
80MYLLuuMhn0qLG9ZDV2nral
```

Renew a specific lease within Vault

```bash
$ LEASE_ID=$(vault list -format=json sys/leases/lookup/database/creds/readonly | jq -r ".[0]")
$ vault lease renew database/creds/readonly/$LEASE_ID
Key                Value
---                -----
lease_id           database/creds/readonly/80MYLLuuMhn0qLG9ZDV2nral
lease_duration     1h
lease_renewable    true
```

Revoke a specific lease within Vault and view active leases

```bash
$ vault lease revoke database/creds/readonly/$LEASE_ID
All revocation operations queued successfully!
$ vault list sys/leases/lookup/database/creds/readonly
No value found at sys/leases/lookup/database/creds/readonly
```

#### Transit Engine

Added a simple transit engine with the following aes256 default configurations

```bash
# After running Vault and applying Terraform
$ ./tests/encrypt-data.sh 'this is a test'
vault:v1:1r3wZyM53ReW2ElRBgX2Rjkb5nbzyqquvQ9lWdYfXZ9HP1Le5nv86OjfPQ==
$ ./tests/decrypt-data.sh 'vault:v1:1r3wZyM53ReW2ElRBgX2Rjkb5nbzyqquvQ9lWdYfXZ9HP1Le5nv86OjfPQ=='
this is a test
```

## Enterprise

Running the above setup with Enterprise binaries will enable certain Enterprise only features for testing (such as namespaces). The following is required to run [setup](#setup) with Enterprise binaries.

- Enterprise binaries downloaded locally with `-ent` appended and present in your `$PATH`. e.g. `vault-ent`
- Enterprise licenses exported in your shell when sourcing `./scripts/export-secrets.sh`. e.g. `VAULT_LICENSE=<lic>`

With the above two present, run through [setup](#setup) to enable Enterprise only endpoints.

[templates]: https://pkg.go.dev/text/template
[ct-lang]: https://github.com/hashicorp/consul-template/blob/main/docs/templating-language.md:
