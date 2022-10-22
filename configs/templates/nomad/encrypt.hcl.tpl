server {
	encrypt = "{{ with secret (print "secrets/nomad/server/config") }}{{ .Data.data.encrypt }}{{ end }}"
}