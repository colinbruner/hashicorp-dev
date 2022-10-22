resource "nomad_acl_policy" "readonly" {
  name        = "readonly"
  description = "Read only policy"
  rules_hcl   = file("${path.module}/policies/readonly.hcl")
}

resource "nomad_acl_role" "readonly" {
  name        = "readonly"
  description = "An ACL Role for default readonly permissions"

  policy {
    name = nomad_acl_policy.readonly.name
  }
}
