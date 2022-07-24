ARG PIHOLE_BASE
FROM "${PIHOLE_BASE:-ghcr.io/pi-hole/docker-pi-hole-base:bullseye-slim}"
# Install requirements for add-on
RUN \
  apk add --no-cache \
    docker \
    docker-compose

# Python 3 HTTP Server serves the current working dir
# So let's set it to our add-on persistent data directory.
WORKDIR /data
RUN apk add docker docker-compose
# Copy data for add-on

#COPY docker-compose.yml /
#RUN docker-compose up
RUN docker volume create pihole_app
RUN docker volume create dns_config
CMD [ "docker run --name=pihole -e TZ=Europe/Madrid -e WEBPASSWORD=rodolfo -e SERVERIP=127.0.0.1 -v pihole_app:/etc/pihole -v dns_config:/etc/dnsmasq.d -p 88:80 -p 58:53/tcp -p 58:53/udp --restart=unless-stopped pihole/pihole" ]

