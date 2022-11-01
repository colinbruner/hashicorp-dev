resource "nomad_acl_policy" "node_write" {
  name        = "node-write"
  description = "Node write policy"
  rules_hcl   = file("${path.module}/policies/node-write.hcl")
}
