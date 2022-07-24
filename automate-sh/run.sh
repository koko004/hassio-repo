#!/usr/bin/with-contenv bashio

mkdir -p ~/.docker-compose/pihole
cd ~/.docker-compose/pihole
docker-compose up
git clone https://github.com/koko004/hassio-repo
cd hassio repo
cd automate-sh
cd pi-hole
docker-compose up
