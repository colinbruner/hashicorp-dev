###
# Intermediate CA
###

resource "vault_mount" "intermediate" {
  path        = "pki-int"
  type        = "pki"
  description = "PKI Mount for Vault Intermediate Root CA"

  default_lease_ttl_seconds = 0
  max_lease_ttl_seconds     = 157680000 # 43800h
}

# Create CSR
resource "vault_pki_secret_backend_intermediate_cert_request" "intermediate" {
  depends_on  = [vault_mount.intermediate]
  backend     = vault_mount.intermediate.path
  type        = "internal"
  common_name = var.int_ca_common_name
}

# Ask root certificate to sign CSR
resource "vault_pki_secret_backend_root_sign_intermediate" "root" {
  depends_on = [vault_pki_secret_backend_intermediate_cert_request.intermediate]

  backend     = vault_mount.root.path
  csr         = vault_pki_secret_backend_intermediate_cert_request.intermediate.csr
  format      = "pem_bundle"
  ttl         = 157680000 # 43800h
  common_name = "${var.root_ca_common_name} Intermediate CA"
}

# Import signed certificate into Vault as the intermediate root CA cert
resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
  backend = vault_mount.intermediate.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.root.certificate
}
