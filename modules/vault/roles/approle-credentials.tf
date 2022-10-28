###
# Creates approle to be logged into by approle-manager
# This approle is responsible for generating credentials from Vault and injecting elsewhere.
###

resource "vault_approle_auth_backend_role" "approle_credentials" {
  backend   = var.auth_backend_approle_path
  role_name = "approle-credentials"

  token_policies = [
    var.policy.approle_login,
    var.policy.approle_admin
  ]
}
