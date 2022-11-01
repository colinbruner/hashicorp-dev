output "readonly" {
  value = nomad_acl_policy.readonly.name
}

output "node_write" {
  value = nomad_acl_policy.node_write.name
}
