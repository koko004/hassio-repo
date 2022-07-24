ARG BUILD_FROM
FROM $BUILD_FROM
RUN \
  apk add --no-cache \
    docker \
    docker-compose \
    curl \
    bash

CMD [ "curl -sSL https://install.pi-hole.net | bash" ]

