ARG BUILD_FROM
FROM $BUILD_FROM
COPY -r docker-pi-hole/ /
RUN cd /docker-pi-hole
CMD [ "docker-compose up" ]

