FROM alpine:3.16.0

RUN apk add --no-cache --update dropbear nano uuidgen \
    && adduser -D -s /bin/sh survey \
    && mkdir -p /etc/dropbear

CMD ["/opt/entrypoint.sh"]
