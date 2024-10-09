FROM alpine

RUN apk update && apk add curl bash openssh-client jq git

COPY backup.sh /backup.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]