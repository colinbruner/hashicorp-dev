###
# Root CA
###

resource "vault_mount" "root" {
  path        = "pki"
  type        = "pki"
  description = "PKI Mount for Vault Root CA"

  default_lease_ttl_seconds = 0
  max_lease_ttl_seconds     = 315360000 # 87600h
}


resource "vault_pki_secret_backend_root_cert" "root" {
  depends_on         = [vault_mount.root]
  backend            = vault_mount.root.path
  type               = "internal"
  common_name        = var.root_ca_common_name
  ttl                = "315360000"
  format             = "pem"
  private_key_format = "der"
  key_type           = "rsa"
  key_bits           = 4096
}
