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

# Copy data for add-on
#COPY run2.sh /
COPY docker-compose.yml /
#RUN docker-compose up

CMD [ "docker-compose up" ]
