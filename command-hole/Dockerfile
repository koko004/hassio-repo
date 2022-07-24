ARG BUILD_FROM
FROM $BUILD_FROM
# Install requirements for add-on
RUN \
  apk add --no-cache \
    docker \
    docker-compose

RUN apk add docker
RUN apk add docker-compose
RUN docker volume create pihole_app
RUN docker volume create dns_config
CMD [ "docker run --name=pihole -e TZ=Europe/Madrid -e WEBPASSWORD=rodolfo -e SERVERIP=127.0.0.1 -v pihole_app:/etc/pihole -v dns_config:/etc/dnsmasq.d -p 88:80 -p 58:53/tcp -p 58:53/udp --restart=unless-stopped pihole/pihole" ]


#docker volume create pihole_app
#docker volume create dns_config
#docker run --name=pihole -e TZ=Europe/Madrid -e WEBPASSWORD=rodolfo -e SERVERIP=YourIPAddressHere -v pihole_app:/etc/pihole -v dns_config:/etc/dnsmasq.d -p 88:80 -p 58:53/tcp -p 58:53/udp --restart=unless-stopped pihole/pihole
