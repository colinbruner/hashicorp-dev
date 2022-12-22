# Bind to local IPv4 addresses
bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"192.168.0.0/22\" | attr \"address\" }}"
#bind_addr = "127.0.0.1"
