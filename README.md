# Ssh-server 

This is ssh-server docker image only for forwarding ports 
for development, tests and connects to your docker networks.

## Build

```bash
docker run -d --name forwarder -v /root/.ssh/authorized_keys:/home/forward/.ssh/authorized_keys:ro -v /etc/ssh/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key:ro -v /etc/ssh/ssh_host_dsa_key:/etc/ssh/ssh_host_ecdsa_key:ro -v /etc/ssh/ssh_host_ed25519_key:/etc/ssh/ssh_host_ed25519_key:ro -p 33322:22 vd2org/forwarder:1.0
```

For example, your can make your own **ngrok** or **serveo**. Config your **nginx** or **traefik**
to frorward connections to container _forward_ and port 8080. 

# On client

```bash
ssh -o ServerAliveInterval=3 -o ServerAliveCountMax=1 -R 8080:localhost:8080 -p 33322 -N -T forward@HOST
```
