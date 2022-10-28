data "vault_policy_document" "approle_admin" {
  rule {
    path         = "auth/approle/role/+/role-id"
    capabilities = ["read"]
    description  = "Allow access to read ANY role-id"
  }

  rule {
    path         = "auth/approle/role/+/secret-id"
    capabilities = ["update"]
    description  = "Allow access to generate ANY secret-id"
  }
}

resource "vault_policy" "approle_admin" {
  name   = "approle-admin"
  policy = data.vault_policy_document.approle_admin.hcl
}
