FROM alpine:3.20

# 1. Instalar herramientas del sistema, jq, bash y librerías de ejecución
RUN apk add --no-cache \
        bash \
        jq \
        neon \
        libxml2 \
        libusb \
        net-snmp-libs \
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
    \
# 2. Descargar y compilar NUT con soporte XML
    && curl -L https://github.com/networkupstools/nut/archive/refs/tags/v2.8.5.tar.gz -o nut-2.8.5.tar.gz \
    && tar -xzf nut-2.8.5.tar.gz \
    && cd nut-2.8.5 \
    && export WITHOUT_NUT_AUGEAS=true \
    && ./autogen.sh \
    && ./configure \
        --prefix=/usr \
        --sysconfdir=/etc/nut \
        --libexecdir=/usr/libexec/nut \
        --with-user=root \
        --with-group=root \
        --with-usb \
        --with-xml \
        --with-snmp \
    && make -j$(nproc) \
    && make install \
    \
# 3. Limpieza de dependencias de desarrollo
    && cd .. \
    && rm -rf nut-2.8.5 nut-2.8.5.tar.gz \
    && apk del .build-deps \
    \
# 4. Crear directorios de estado para NUT
    && mkdir -p /var/state/ups && chmod 0750 /var/state/ups

# Copiar el script de inicio
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
