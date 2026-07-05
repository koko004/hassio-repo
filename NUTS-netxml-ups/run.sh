#!/bin/bash
OPTIONS_FILE="/data/options.json"
DEVICE_NAME=$(jq --raw-output '.device_name' $OPTIONS_FILE)
DRIVER=$(jq --raw-output '.driver' $OPTIONS_FILE)
PORT=$(jq --raw-output '.port' $OPTIONS_FILE)
USERNAME=$(jq --raw-output '.username' $OPTIONS_FILE)
PASSWORD=$(jq --raw-output '.password' $OPTIONS_FILE)

# 1. Ajustar permisos de la carpeta de estado para que el proceso no falle
mkdir -p /var/state/ups
chown -R root:root /var/state/ups
chmod 777 /var/state/ups

# 2. Configurar NUT (sin forzar usuarios de sistema inexistentes)
cat << EOF > /etc/nut/ups.conf
[$DEVICE_NAME]
    driver = $DRIVER
    port = $PORT
    desc = "UPS Eaton"
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

# 3. Lanzar procesos
echo "[INFO] Iniciando driver $DRIVER..."
/usr/libexec/nut/$DRIVER -D -a $DEVICE_NAME &
sleep 5

echo "[INFO] Iniciando upsd..."
/usr/sbin/upsd -D &
sleep 2

echo "[INFO] Iniciando upsmon..."
exec /usr/sbin/upsmon -D
