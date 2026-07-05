#!/bin/bash
OPTIONS_FILE="/data/options.json"
DEVICE_NAME=$(jq --raw-output '.device_name' $OPTIONS_FILE)
DRIVER=$(jq --raw-output '.driver' $OPTIONS_FILE)
# Limpiamos el puerto para asegurar que sea solo la IP
PORT=$(jq --raw-output '.port' $OPTIONS_FILE | sed 's|http://||' | sed 's|/||g')
USERNAME=$(jq --raw-output '.username' $OPTIONS_FILE)
PASSWORD=$(jq --raw-output '.password' $OPTIONS_FILE)

# Configuración de archivos
cat << EOF > /etc/nut/ups.conf
[$DEVICE_NAME]
    driver = $DRIVER
    port = $PORT
EOF

cat << EOF > /etc/nut/upsd.conf
LISTEN 0.0.0.0 3493
EOF

cat << EOF > /etc/nut/upsd.users
[admin]
    password = $PASSWORD
    actions = SET
    instcmds = ALL
EOF

cat << EOF > /etc/nut/upsmon.conf
MONITOR $DEVICE_NAME@localhost 1 admin $PASSWORD primary
SHUTDOWNCMD "/sbin/shutdown -h now"
POWERDOWNFLAG /etc/killpower
EOF

chmod 640 /etc/nut/*

# Ejecución
/usr/libexec/nut/$DRIVER -D -a $DEVICE_NAME &
sleep 5
/usr/sbin/upsd -D &
exec /usr/sbin/upsmon -D
