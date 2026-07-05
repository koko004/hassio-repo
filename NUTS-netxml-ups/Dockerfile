Usamos alpine oficial de Docker Hub para evitar bloqueos por DNS/IP de GHCR

FROM alpine:3.20

STREAMING_CHUNK: Instalando paquetes necesarios en Alpine...

1. Instalar herramientas del sistema, jq, bash y librerías de ejecución esenciales

RUN apk add --no-cache 

bash 

jq 

neon 

libxml2 

libusb 

net-snmp-libs 

&& apk add --no-cache --virtual .build-deps 

build-base 

neon-dev 

libxml2-dev 

libusb-dev 

net-snmp-dev 

openssl-dev 

curl 

tar 

make 

libtool 

autoconf 

automake 

\

STREAMING_CHUNK: Descargando y compilando NUT optimizado...

2. Descargar y compilar NUT optimizado

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
    --with-drivers=netxml-ups,usbhid-ups,snmp-ups \
    --with-usb \
    --with-xml \
    --with-snmp \
    --without-doc \
    --without-api \
    --without-cgi \
    --without-ssl \
    --without-python \
&& make -j$(nproc) \
&& make install \
\


STREAMING_CHUNK: Limpiando el entorno de compilación...

3. Limpieza profunda de dependencias de desarrollo para aligerar la imagen

&& cd .. \
&& rm -rf nut-2.8.5 nut-2.8.5.tar.gz \
&& apk del .build-deps \
\


4. Crear directorios de estado para NUT

&& mkdir -p /var/state/ups && chmod 0750 /var/state/ups


Copiar el script de inicio

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
