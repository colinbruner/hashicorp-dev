###
# Creates approle to be logged into by approle-manager
# This approle is responsible for writing secrets to Vault
###

resource "vault_approle_auth_backend_role" "approle_secrets" {
  backend   = var.auth_backend_approle_path
  role_name = "approle-secrets"

  token_policies = [
    var.policy.secret_admin
  ]
}
