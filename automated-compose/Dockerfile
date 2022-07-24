ARG BUILD_FROM
FROM $BUILD_FROM
# Install requirements for add-on
RUN \
  apk add --no-cache \
    docker docker-compose
COPY docker-compose.yml /
CMD [ "/docker-compose up" ]

