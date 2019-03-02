# Ssh-server 

This is ssh-server docker image only for forwarding ports 
for development, tests and connects to your docker networks.

## Build

```bash
cp ~/.ssh/authorized_keys ./
docker build -t forward https://raw.githubusercontent.com/vd2org/ssh-forward/master/Dockerfile
docker run --network NETWORK --name forward -d -p 33322:22 forward
```

For example, your can make your own **ngrok** or **serveo**. Config your **nginx** or **traefik**
to frorward connections to container _forward_ and port 8080. 

# On client

```bash
ssh -o ServerAliveInterval=3 -o ServerAliveCountMax=1 -R 8080:localhost:8080 -p 33322 -N -T forward@HOST
```

