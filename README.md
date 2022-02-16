# Ssh-server 

This is ssh-server docker image only for forwarding ports 
for development, tests and connects to your docker networks.

For example, your can make your own **ngrok** or **serveo**. Config your **nginx** or **traefik**
to forward connections to container _ssh-forward_ and port 8080. 

### Supported platforms

* linux/amd64
* linux/arm64

### Available versions

[Here](https://github.com/users/vd2org/packages/container/package/ssh-forward)

### Starting with just using docker

```bash
docker run -d --name ssh-forward \
  -v /root/.ssh/authorized_keys:/home/forward/.ssh/authorized_keys:ro \
  -v /etc/ssh/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key:ro \
  -v /etc/ssh/ssh_host_dsa_key:/etc/ssh/ssh_host_ecdsa_key:ro \
  -v /etc/ssh/ssh_host_ed25519_key:/etc/ssh/ssh_host_ed25519_key:ro 
  -p 33322:22 ghcr.io/vd2org/ssh-forward:2.0
```
### Starting with using docker compose

```shell
curl https://raw.githubusercontent.com/vd2org/ssh-forward/2.0/compose.yml -o compose.yml 
docker compose up
```

### Connecting

```bash
ssh -o ServerAliveInterval=3 -o ServerAliveCountMax=1 -R 8080:localhost:8080 -p 33322 -N -T forward@HOST
```
