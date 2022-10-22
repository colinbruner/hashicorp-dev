resource "consul_acl_policy" "kv_read" {
  name  = "kv-read"
  rules = file("${path.module}/policies/kv-read.hcl")
}

resource "consul_acl_role" "kv_read" {
  name        = "kv-read"
  description = "Role for kv read."

  policies = [
    consul_acl_policy.kv_read.id
  ]
}
