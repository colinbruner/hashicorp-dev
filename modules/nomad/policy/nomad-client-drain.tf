resource "nomad_acl_policy" "nomad_client_drain" {
  name        = "nomad-client-drain"
  description = "Allows Nomad Clients to drain their workloads on termination."
  rules_hcl   = file("${path.module}/policies/nomad-client-drain.hcl")
}
