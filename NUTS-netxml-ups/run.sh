#!/bin/bash
OPTIONS_FILE="/data/options.json"
DEVICE_NAME=$(jq --raw-output '.device_name' $OPTIONS_FILE)
DRIVER=$(jq --raw-output '.driver' $OPTIONS_FILE)
PORT=$(jq --raw-output '.port' $OPTIONS_FILE)
USERNAME=$(jq --raw-output '.username' $OPTIONS_FILE)
PASSWORD=$(jq --raw-output '.password' $OPTIONS_FILE)

# Verificamos si existe el driver
if [ ! -f "/usr/libexec/nut/$DRIVER" ]; then
    echo "[ERROR] El driver $DRIVER no se encuentra en /usr/libexec/nut/"
    echo "Contenido de la carpeta:"
    ls -l /usr/libexec/nut/
    exit 1
fi

cat << EOF > /etc/nut/ups.conf
[$DEVICE_NAME]
    driver = $DRIVER
    port = $PORT
    user = $USERNAME
    password = $PASSWORD
EOF

cat << EOF > /etc/nut/upsd.conf
LISTEN 0.0.0.0 3493
EOF

cat << EOF > /etc/nut/upsd.users
[$USERNAME]
    password = $PASSWORD
    actions = SET
    instcmds = ALL
EOF

cat << EOF > /etc/nut/upsmon.conf
MONITOR $DEVICE_NAME@localhost 1 $USERNAME $PASSWORD primary
SHUTDOWNCMD "/sbin/shutdown -h now"
EOF

chmod 640 /etc/nut/*
echo "[INFO] Iniciando $DRIVER..."
/usr/libexec/nut/$DRIVER -D -a $DEVICE_NAME &
sleep 5
/usr/sbin/upsd -D &
exec /usr/sbin/upsmon -D
