resource "vault_database_secret_backend_role" "readonly" {
  name        = "readonly"
  backend     = vault_database_secrets_mount.database.path
  db_name     = vault_database_secrets_mount.database.postgresql[0].name
  default_ttl = 3600
  max_ttl     = 86400
  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT;",
    "GRANT ro TO \"{{name}}\";",
  ]
}
