data "vault_policy_document" "approle_manager" {
  rule {
    path         = "auth/approle/login"
    capabilities = ["create"]
    description  = "Allow approle to login"
  }

  # Allow read on approle-secrets and approle-credentials role-id
  dynamic "rule" {
    for_each = toset(["approle-secrets", "approle-credentials"])
    content {
      path         = "auth/approle/role/${rule.key}/role-id"
      capabilities = ["read"]
      description  = "Allow approle to read ${rule.key} role-id"
    }
  }

  # Allow write on approle-secrets and approle-credentials secret-id
  dynamic "rule" {
    for_each = toset(["approle-secrets", "approle-credentials"])
    content {
      path         = "auth/approle/role/${rule.key}/secret-id"
      capabilities = ["update"]
      description  = "Allow approle to read ${rule.key} secret-id"
    }
  }
}

resource "vault_policy" "approle_manager" {
  name   = "approle-manager"
  policy = data.vault_policy_document.approle_manager.hcl
}
