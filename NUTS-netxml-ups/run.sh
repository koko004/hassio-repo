#!/bin/bash

# Leer la configuración directamente desde el JSON de Home Assistant usando jq
OPTIONS_FILE="/data/options.json"

DEVICE_NAME=$(jq --raw-output '.device_name' $OPTIONS_FILE)
DRIVER=$(jq --raw-output '.driver' $OPTIONS_FILE)
PORT=$(jq --raw-output '.port' $OPTIONS_FILE)
USERNAME=$(jq --raw-output '.username' $OPTIONS_FILE)
PASSWORD=$(jq --raw-output '.password' $OPTIONS_FILE)

echo "[INFO] Generando configuración de NUT..."

# 1. Generar /etc/nut/ups.conf
cat << EOF > /etc/nut/ups.conf
[$DEVICE_NAME]
    driver = $DRIVER
    port = $PORT
EOF

# 2. Generar /etc/nut/upsd.conf
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

chmod 640 /etc/nut/*

echo "[INFO] Iniciando el driver de NUT para $DEVICE_NAME..."
/usr/libexec/nut/$DRIVER -D -a $DEVICE_NAME &

sleep 2

echo "[INFO] Iniciando el servidor upsd..."
/usr/sbin/upsd -D &

sleep 1

echo "[INFO] Iniciando el monitor upsmon..."
exec /usr/sbin/upsmon -D
