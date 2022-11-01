module "policy" {
  source = "./policy"
}

module "roles" {
  source = "./roles"

  policy = module.policy
}
