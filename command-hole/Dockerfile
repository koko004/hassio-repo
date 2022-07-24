ARG BUILD_FROM
FROM $BUILD_FROM
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

CMD [ "docker run --name=pihole -e TZ=Europe/Madrid -e WEBPASSWORD=rodolfo -e SERVERIP=YourIPAddressHere -v pihole_app:/etc/pihole -v dns_config:/etc/dnsmasq.d -p 88:80 -p 58:53/tcp -p 58:53/udp --restart=unless-stopped pihole/pihole" ]

#docker volume create pihole_app
#docker volume create dns_config
#docker run --name=pihole -e TZ=Europe/Madrid -e WEBPASSWORD=rodolfo -e SERVERIP=YourIPAddressHere -v pihole_app:/etc/pihole -v dns_config:/etc/dnsmasq.d -p 88:80 -p 58:53/tcp -p 58:53/udp --restart=unless-stopped pihole/pihole
