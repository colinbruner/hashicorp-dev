data "vault_policy_document" "approle_login" {
  rule {
    path         = "auth/approle/login"
    capabilities = ["create"]
    description  = "Allow approle to login"
  }
}

resource "vault_policy" "approle_login" {
  name   = "approle-login"
  policy = data.vault_policy_document.approle_login.hcl
}
