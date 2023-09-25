resource "vault_mount" "transit" {
  path                      = "transit"
  type                      = "transit"
  description               = "Vault Transit Engine"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}


resource "vault_transit_secret_backend_key" "transit_default" {
  backend          = vault_mount.transit.path
  name             = "transit-default-key"
  deletion_allowed = true # Set to 'false' for not-dev
}
