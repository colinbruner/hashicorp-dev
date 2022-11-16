{{- $meta := printf "nomad/client/class/%s/config/client/meta" (env "NOMAD_NODE_CLASS") -}}
client {
  enabled    = true
  node_class = "{{ printf "nomad/client/class/%s/config/client/node_class" (env "NOMAD_NODE_CLASS") | key }}"
  meta = {
    node-pool = "{{ (env "NOMAD_NODE_POOL") }}"
    {{ range tree $meta -}}
    {{ .Key }} = "{{ .Value }}"
    {{ end }}
  }
}
