ARG BUILD_FROM
FROM $BUILD_FROM
RUN \
  apk add --no-cache \
    docker \
    docker-compose \
    curl \
    wget
COPY docker-compose.yml /
CMD [ "/docker-compose up" ]



CMD [ "curl -sSL https://install.pi-hole.net | ash" ]

