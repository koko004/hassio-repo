FROM alpine:3.20

# 1. Instalar librerias de ejecucion esenciales
RUN apk add --no-cache \
        bash \
        jq \
        neon \
        libxml2 \
        libusb \
        net-snmp-libs \
# 2. Instalar herramientas de compilacion (AÑADIDO PYTHON3)
    && apk add --no-cache --virtual .build-deps \
        build-base \
        neon-dev \
        libxml2-dev \
        libusb-dev \
        net-snmp-dev \
        openssl-dev \
        curl \
        tar \
        make \
        libtool \
        autoconf \
        automake \
        python3 \
    \
# 3. Descargar y compilar NUT (ahora autogen.sh funcionara perfecto)
    && curl -L https://github.com/networkupstools/nut/archive/refs/tags/v2.8.5.tar.gz -o nut-2.8.5.tar.gz \
    && tar -xzf nut-2.8.5.tar.gz \
    && cd nut-2.8.5 \
    && ./autogen.sh \
    && ./configure \
        --prefix=/usr \
        --sysconfdir=/etc/nut \
        --libexecdir=/usr/libexec/nut \
        --with-user=root \
        --with-group=root \
        --with-drivers=netxml-ups,usbhid-ups,snmp-ups \
        --with-usb \
        --with-xml \
        --with-snmp \
        --without-doc \
        --without-cgi \
    && make -j$(nproc) \
    && make install \
    \
# 4. Limpieza profunda (aqui se borra Python3 y los compiladores)
    && cd .. \
    && rm -rf nut-2.8.5 nut-2.8.5.tar.gz \
    && apk del .build-deps \
    \
# 5. Crear directorios de estado para NUT
    && mkdir -p /var/state/ups && chmod 0750 /var/state/ups

# Copiar el script de inicio
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
