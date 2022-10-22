resource "vault_mount" "kvv2" {
  path        = "secrets"
  type        = "kv-v2"
  description = "KV Version 2 secret engine mount at /secret"
}
