NOMAD_ADDR="https://127.0.0.1:4646"
NOMAD_TOKEN="{{ with secret "nomad/creds/nomad-client-drain" }}{{ .Data.secret_id }}{{ end }}"