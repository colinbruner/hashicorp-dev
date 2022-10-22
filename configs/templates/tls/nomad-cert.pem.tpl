{{ with secret "pki-int/issue/hashi-dev" "common_name=nomad.dev.colinbruner.com" "alt_names=server.us-east1.nomad" "ip_sans=127.0.0.1" "ttl=8760h" }}
{{ .Data.certificate }}
{{ end }}
