variable "consul_datacenter" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "region" {
  default = "us-east1"
}
