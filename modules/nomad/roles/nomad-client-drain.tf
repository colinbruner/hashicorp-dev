resource "nomad_acl_role" "nomad_client_drain" {
  name        = "nomad-client-drain"
  description = "A role intended to allow a Nomad Client to invoke 'drain -self' on termination."

  policy {
    name = var.policy.node_write
  }
}
