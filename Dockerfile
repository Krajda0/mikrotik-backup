FROM alpine

RUN apk update && apk add curl bash openssh-client jq git

RUN mkdir -p ~/.ssh && mkdir /mikrotik-backup
WORKDIR /mikrotik-backup

COPY backup.sh .

RUN echo "$MIKROTIK_SSH_KEY" > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa && \
    for ROUTER in $ROUTERS; do ssh-keyscan -H $ROUTER >> ~/.ssh/known_hosts || true; done

# Configure cron
RUN mkdir /etc/cron
RUN echo "$CRON /bin/bash /mikrotik-backup/backup.sh" > /etc/cron/crontab

# Init cron
RUN crontab /etc/cron/crontab

CMD ["crond", "-f"]