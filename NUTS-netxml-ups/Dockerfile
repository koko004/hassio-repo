FROM alpine:3.20

RUN apk add --no-cache bash jq neon libxml2 libusb \
    && apk add --no-cache --virtual .build-deps \
        build-base neon-dev libxml2-dev libusb-dev \
        openssl-dev curl tar make libtool autoconf automake \
    && curl -L https://github.com/networkupstools/nut/archive/refs/tags/v2.8.5.tar.gz -o nut-2.8.5.tar.gz \
    && tar -xzf nut-2.8.5.tar.gz && cd nut-2.8.5 \
    && export WITHOUT_NUT_AUGEAS=true \
    && ./autogen.sh \
    && ./configure --prefix=/usr --sysconfdir=/etc/nut --with-drvpath=/usr/libexec/nut \
        --with-drivers=netxml-ups --with-xml --without-snmp --without-usb \
        --without-modbus --without-hidapi --without-doc --disable-nut-scanner \
    && make -j$(nproc) && make install \
    && cd / && rm -rf nut-2.8.5 nut-2.8.5.tar.gz && apk del .build-deps \
    && mkdir -p /var/state/ups && chmod 0777 /var/state/ups

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
