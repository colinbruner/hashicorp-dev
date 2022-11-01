resource "nomad_acl_role" "readonly" {
  name        = "readonly"
  description = "Read only access."

  policy {
    name = var.policy.readonly
  }
}
