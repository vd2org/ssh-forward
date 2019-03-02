# Example usage:
#
# cp ~/.ssh/authorized_keys ./
# docker build -t forward ./
# docker run --network NETWORK --name forward -d -p 33322:22 forward
#
# On client:
#
# ssh -o ServerAliveInterval=3 -o ServerAliveCountMax=1 -R 8080:localhost:8080 -p 33322 -N -T forward@HOST

FROM alpine

RUN apk update && \
    apk add --no-cache openssh-server && \
    ssh-keygen -A && \
    mkdir /none && \
    rm /etc/ssh/sshd_config && \
    echo 'GatewayPorts yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config && \
    echo 'AllowAgentForwarding no' >> /etc/ssh/sshd_config && \
    echo 'PermitTTY no' >> /etc/ssh/sshd_config && \
    echo 'ChrootDirectory /none' >> /etc/ssh/sshd_config && \
    echo 'Banner none' >> /etc/ssh/sshd_config && \
    echo 'ForceCommand echo Welcome to hell!' >> /etc/ssh/sshd_config && \
    rm /etc/passwd && \
    rm /etc/shadow && \
    echo 'sshd:x:22:22:sshd:/dev/null:/sbin/nologin' >> /etc/passwd && \
    echo 'forward:x:1000:1000:Linux User,,,:/home/forward:/sbin/nonexistent' >> /etc/passwd && \
    echo 'sshd:!::0:::::' >> /etc/shadow && \
    echo 'forward::17950:0:99999:7:::' >> /etc/shadow && \
    mkdir -p /home/forward/.ssh && \
    apk del alpine-baselayout alpine-keys musl-utils libc-utils musl && \
    mkdir /var/empty && \
    rm -rf /var/cache/apk/* && \
    rm -rf /usr/bin/ssh-keygen && \
    apk del apk-tools busybox

ADD "authorized_keys" "/home/forward/.ssh/"

CMD ["/usr/sbin/sshd", "-D"]
