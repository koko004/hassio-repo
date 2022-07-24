ARG BUILD_FROM
FROM $BUILD_FROM
RUN \
  apk add --no-cache \
    docker \
    docker-compose \
    curl \
    wget

CMD [ "curl -sSL https://install.pi-hole.net | sh" ]

