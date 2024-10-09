#!/usr/bin/env bash

echo "$MIKROTIK_SSH_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
for ROUTER in $ROUTERS;do ssh-keyscan -H $ROUTER >> ~/.ssh/known_hosts || true;done

# Configure cron
RUN mkdir /etc/cron
RUN echo "${CRON} /backup.sh" > /etc/cron/crontab

#Run cron
crontab -l /etc/cron/crontab
exec cron -f