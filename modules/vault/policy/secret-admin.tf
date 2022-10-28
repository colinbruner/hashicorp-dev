data "vault_policy_document" "secret_admin" {
  rule {
    path         = "secret/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "List, create, update, and delete key/value secrets"
  }
}

resource "vault_policy" "secret_admin" {
  name   = "secret-admin"
  policy = data.vault_policy_document.secret_admin.hcl
}
