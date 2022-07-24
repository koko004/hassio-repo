ARG BUILD_FROM
FROM $BUILD_FROM
RUN \
  apk add --no-cache \
    docker \
    docker-compose \
    curl \
    bash

COPY pihole.sh /
RUN \
  chmod +x pihole.sh \
  
CMD [ "./pihole.sh" ]

