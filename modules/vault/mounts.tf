resource "vault_mount" "kvv2" {
  path        = "secret"
  type        = "kv-v2"
  description = "KV Version 2 secret engine mount at /secret"
}
