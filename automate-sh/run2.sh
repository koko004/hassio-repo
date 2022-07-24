
#!/usr/bin/with-contenv bashio

docker volume create pihole_app
docker volume create dns_config
docker run --name=pihole -e TZ=Europe/Madrid -e WEBPASSWORD=rododolfo -e SERVERIP=192.168.1.229 -v pihole_app:/etc/pihole -v dns_config:/etc/dnsmasq.d -p 88:80 -p 58:53/tcp -p 58:53/udp --restart=unless-stopped pihole/pihole
