variable "auth_backend_approle_path" {
  type        = string
  description = "The approle mount path"
}

variable "policy" {
  description = "A map of policies, by name"
}
