# Bind to local network
#bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"192.168.0.0/22\" | attr \"address\" }}"
bind_addr = "0.0.0.0"

advertise {
  # Bind to local network
  #http = "{{ GetPrivateInterfaces | include \"network\" \"192.168.0.0/22\" | attr \"address\" }}"
  rpc  = "127.0.0.1"
  serf = "127.0.0.1"
}

server {
  enabled = true
}

client {
  enabled = true
  node_class = "region"
  options {
    "driver.raw_exec.enable"    = "1"
    "docker.privileged.enabled" = "true"
  }

  meta {
    region = "region"
    datacenter = "region"
    class = "region"
    nomad-node-pool = "compute-dev-blue"
  }
}

plugin "docker" {
  config {
    volumes {
      enabled      = true
    }

    allow_privileged = true
  }
}

consul {
  address = "127.0.0.1:8500"
}

telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
  prometheus_metrics         = true
}

vault {
  enabled = true
  address = "http://127.0.0.1:8200"
  token = "vault-root-dev"
}
