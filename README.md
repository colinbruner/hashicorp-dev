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

## Enterprise

Running the above setup with Enterprise binaries will enable certain Enterprise only features for testing (such as namespaces). The following is required to run [setup](#setup) with Enterprise binaries.

- Enterprise binaries downloaded locally with `-ent` appended and present in your `$PATH`. e.g. `vault-ent`
- Enterprise licenses exported in your shell when sourcing `./scripts/export-secrets.sh`. e.g. `VAULT_LICENSE=<lic>`

With the above two present, run through [setup](#setup) to enable Enterprise only endpoints.

[templates]: https://pkg.go.dev/text/template
[ct-lang]: https://github.com/hashicorp/consul-template/blob/main/docs/templating-language.md:
