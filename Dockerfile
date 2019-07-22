# Example usage:
#
# docker run --name forwarder -v /root/.ssh/authorized_keys:/home/forward/.ssh/authorized_keys:ro -v /etc/ssh/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key:ro -v /etc/ssh/ssh_host_dsa_key:/etc/ssh/ssh_host_ecdsa_key:ro -v /etc/ssh/ssh_host_ed25519_key:/etc/ssh/ssh_host_ed25519_key:ro -p 33322:22 forwarder
# On client:
#
# ssh -o ServerAliveInterval=3 -o ServerAliveCountMax=1 -R 8080:localhost:8080 -p 33322 -N -T forward@HOST

FROM alpine:3.10

RUN apk update && \
    apk add --no-cache openssh-server && \
    rm /etc/ssh/sshd_config && \
    echo 'GatewayPorts yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config && \
    echo 'PidFile none' >> /etc/ssh/sshd_config && \
    echo 'AllowAgentForwarding no' >> /etc/ssh/sshd_config && \
    echo 'PermitTTY no' >> /etc/ssh/sshd_config && \
    echo 'ChrootDirectory /none' >> /etc/ssh/sshd_config && \
    echo 'Banner none' >> /etc/ssh/sshd_config && \
    echo 'AllowUsers forward' >> /etc/ssh/sshd_config && \
    echo 'ForceCommand echo Welcome to forwarder!' >> /etc/ssh/sshd_config && \
    rm /etc/passwd && \
    rm /etc/shadow && \
    echo 'sshd:x:22:22:sshd:/dev/null:/sbin/nologin' >> /etc/passwd && \
    echo 'forward:x:0:0:forward,,,:/home/forward:/sbin/nologin' >> /etc/passwd && \
    echo 'sshd:!:::::::' >> /etc/shadow && \
    echo 'forward::::::::' >> /etc/shadow && \
    mkdir /none && \
    mkdir -p /home/forward/.ssh && \
    apk del alpine-baselayout alpine-keys musl-utils libc-utils musl && \
    mkdir /var/empty && \
    rm -rf /var/cache/apk/* && \
    rm -rf /usr/bin/ssh-keygen && \
    apk del apk-tools busybox

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
