server {
	encrypt = "{{ with secret (print "secret/nomad/server/config") }}{{ .Data.data.encrypt }}{{ end }}"
}