# SSH frowarder service

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
    
EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
