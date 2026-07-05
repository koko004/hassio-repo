#!/usr/bin/with-contenv bashio

DEVICE_NAME=$(bashio::config 'device_name')
DRIVER=$(bashio::config 'driver')
PORT=$(bashio::config 'port')
USERNAME=$(bashio::config 'username')
PASSWORD=$(bashio::config 'password')

bashio::log.info "Generando configuración de NUT..."

# 1. Generar /etc/nut/ups.conf
cat << EOF > /etc/nut/ups.conf
[$DEVICE_NAME]
    driver = $DRIVER
    port = $PORT
EOF

# 2. Generar /etc/nut/upsd.conf (Escuchar en todas las interfaces del contenedor)
cat << EOF > /etc/nut/upsd.conf
LISTEN 0.0.0.0 3493
EOF

# 3. Generar /etc/nut/upsd.users
cat << EOF > /etc/nut/upsd.users
[$USERNAME]
    password = $PASSWORD
    actions = SET
    instcmds = ALL
EOF

# 4. Generar /etc/nut/upsmon.conf
cat << EOF > /etc/nut/upsmon.conf
MONITOR $DEVICE_NAME@localhost 1 $USERNAME $PASSWORD primary
SHUTDOWNCMD "/sbin/shutdown -h now"
EOF

# Asegurar permisos correctos
chmod 640 /etc/nut/*

bashio::log.info "Iniciando el driver de NUT para $DEVICE_NAME..."
/usr/libexec/nut/$DRIVER -D -a $DEVICE_NAME &

# Darle un par de segundos al driver para levantar el socket
sleep 2

bashio::log.info "Iniciando el servidor upsd..."
/usr/sbin/upsd -D &

sleep 1

bashio::log.info "Iniciando el monitor upsmon..."
# Ejecutamos el último en primer plano para que el contenedor no se cierre
exec /usr/sbin/upsmon -D
