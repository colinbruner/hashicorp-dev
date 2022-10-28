###
# Creates approle to be logged into by approle-manager
# This approle is responsible for logging into approle-secrets and approle-credentials
###

resource "vault_approle_auth_backend_role" "approle_manager" {
  backend   = var.auth_backend_approle_path
  role_name = "approle-manager"

  token_policies = [
    var.policy.approle_login,
    var.policy.approle_manager
  ]
}
