output "approle_admin" {
  value = vault_policy.approle_admin.name
}

output "approle_login" {
  value = vault_policy.approle_login.name
}

output "approle_manager" {
  value = vault_policy.approle_manager.name
}

output "secret_admin" {
  value = vault_policy.secret_admin.name
}
