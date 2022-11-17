
# Create Intermediate Certificate Role, two variables and generic defaults for testing
resource "vault_pki_secret_backend_role" "intermediate" {
  backend          = vault_mount.intermediate.path
  name             = var.pki_role_name
  key_usage        = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
  ttl              = 15768000 #6months
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 2048
  allow_localhost  = true
  allowed_domains  = var.pki_role_allowed_domains
  allow_subdomains = true
}

# Nomad Server PKI Role
resource "vault_pki_secret_backend_role" "nomad_server" {
  backend          = vault_mount.intermediate.path
  name             = "nomad-server"
  key_usage        = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
  ttl              = 15768000 #6months
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 2048
  allow_localhost  = true
  allowed_domains  = var.pki_role_allowed_domains
  allow_subdomains = true
}

# Nomad Client PKI Role
resource "vault_pki_secret_backend_role" "nomad_client" {
  backend          = vault_mount.intermediate.path
  name             = "nomad-client"
  key_usage        = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
  ttl              = 15768000 #6months
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 2048
  allow_localhost  = true
  allowed_domains  = var.pki_role_allowed_domains
  allow_subdomains = true
}
