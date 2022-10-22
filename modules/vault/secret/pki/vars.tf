variable "root_ca_common_name" {
  type    = string
  default = "colinbruner.com"
}

variable "int_ca_common_name" {
  type    = string
  default = "int.colinbruner.com"
}

variable "pki_role_name" {
  type    = string
  default = "hashi-dev"
}

# Allow domains for testing
variable "pki_role_allowed_domains" {
  type = list(string)
  default = [
    "colinbruner.com",
    "dev.colinbruner.com",
    "us-east1.nomad",
    "us-east1.consul",
  ]
}

