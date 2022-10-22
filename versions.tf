terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.16.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.9.1"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "1.4.19"
    }
  }
}

provider "consul" {}
provider "vault" {}
provider "nomad" {}
