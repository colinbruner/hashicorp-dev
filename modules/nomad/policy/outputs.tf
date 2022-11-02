output "readonly" {
  value = nomad_acl_policy.readonly.name
}

output "nomad_client_drain" {
  value = nomad_acl_policy.nomad_client_drain.name
}
