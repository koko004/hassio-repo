FROM alpine:3.20

RUN apk add --no-cache \
        bash jq neon libxml2 libusb net-snmp-libs \
    && apk add --no-cache --virtual .build-deps \
        build-base neon-dev libxml2-dev libusb-dev net-snmp-dev \
        openssl-dev curl tar make libtool autoconf automake python3 \
    && curl -L https://github.com/networkupstools/nut/archive/refs/tags/v2.8.5.tar.gz -o nut-2.8.5.tar.gz \
    && tar -xzf nut-2.8.5.tar.gz && cd nut-2.8.5 \
    && ./autogen.sh && ./configure --prefix=/usr --sysconfdir=/etc/nut --libexecdir=/usr/libexec/nut \
        --with-drivers=netxml-ups,usbhid-ups,snmp-ups --with-usb --with-xml --with-snmp --without-doc --without-cgi \
    && make -j$(nproc) && make install \
    && mkdir -p /usr/libexec/nut \
    && cp drivers/netxml-ups /usr/libexec/nut/ \
    && chmod +x /usr/libexec/nut/netxml-ups \
    && cd .. && rm -rf nut-2.8.5 nut-2.8.5.tar.gz && apk del .build-deps \
    && mkdir -p /var/state/ups && chmod 0750 /var/state/ups

COPY run.sh /run.sh
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
