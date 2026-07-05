FROM alpine:3.20

# 1. Instalar dependencias
RUN apk add --no-cache bash jq neon libxml2 libusb net-snmp-libs \
    && apk add --no-cache --virtual .build-deps \
        build-base neon-dev libxml2-dev libusb-dev net-snmp-dev \
        openssl-dev curl tar make libtool autoconf automake \
    \
    # 2. Descargar y compilar
    && curl -L https://github.com/networkupstools/nut/archive/refs/tags/v2.8.5.tar.gz -o nut-2.8.5.tar.gz \
    && tar -xzf nut-2.8.5.tar.gz && cd nut-2.8.5 \
    && export WITHOUT_NUT_AUGEAS=true \
    && ./autogen.sh \
    && ./configure --prefix=/usr --sysconfdir=/etc/nut --libexecdir=/usr/libexec/nut \
        --with-drivers=netxml-ups --with-xml --disable-nut-scanner --without-doc \
    && make -j$(nproc) && make install \
    \
    # 3. BÚSQUEDA ROBUSTA: Busca el binario y lo copia a la carpeta final
    && mkdir -p /usr/libexec/nut \
    && find . -name "netxml-ups" -type f -exec cp {} /usr/libexec/nut/netxml-ups \; \
    && chmod +x /usr/libexec/nut/netxml-ups \
    \
    # 4. Limpieza
    && cd .. && rm -rf nut-2.8.5 nut-2.8.5.tar.gz && apk del .build-deps \
    && mkdir -p /var/state/ups && chmod 0777 /var/state/ups

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
