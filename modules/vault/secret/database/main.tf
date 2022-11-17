resource "vault_database_secrets_mount" "database" {
  path = "database"

  postgresql {
    name              = "db1"
    username          = "root"
    password          = "rootpassword"
    connection_url    = "postgresql://{{username}}:{{password}}@127.0.0.1:5432/postgres?sslmode=disable"
    verify_connection = true
    allowed_roles = [
      "readonly",
    ]
  }
}
