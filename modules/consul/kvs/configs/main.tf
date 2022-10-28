
resource "consul_key_prefix" "testing_one" {
  datacenter = "dc1"

  path_prefix = "config/testing/"

  subkeys = {
    "test"  = "value"
    "thing" = "asdf"
    "foo" = jsonencode({
      "asdf" = "bar"
    })

    "bool/thing" = true

    "new/will" = "this"
    "new/work" = 0
  }
  subkey {
    path  = "alist"
    value = jsonencode(["a", "bunch", "of", "string", "list", "values"])
  }
}
