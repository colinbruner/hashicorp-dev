resource "nomad_acl_policy" "readonly" {
  name        = "readonly"
  description = "Read only policy"
  rules_hcl   = file("${path.module}/policies/readonly.hcl")
}
