#!/bin/bash
OPTIONS_FILE="/data/options.json"
DEVICE_NAME=$(jq --raw-output '.device_name' $OPTIONS_FILE)
DRIVER=$(jq --raw-output '.driver' $OPTIONS_FILE)
URL=$(jq --raw-output '.port' $OPTIONS_FILE)
USER=$(jq --raw-output '.username' $OPTIONS_FILE)
PASS=$(jq --raw-output '.password' $OPTIONS_FILE)

# Crear archivos de config necesarios
cat << EOF > /etc/nut/ups.conf
[$DEVICE_NAME]
    driver = $DRIVER
    port = $URL
EOF
cat << EOF > /etc/nut/upsd.conf
LISTEN 0.0.0.0 3493
EOF
cat << EOF > /etc/nut/upsd.users
[$USER]
    password = $PASS
    actions = SET
    instcmds = ALL
EOF

# Verificar existencia del driver antes de arrancar
if [ ! -f "/usr/libexec/nut/$DRIVER" ]; then
    echo "[ERROR] El driver $DRIVER no existe en /usr/libexec/nut/"
    ls -l /usr/libexec/nut/
    exit 1
fi

echo "[INFO] Arrancando $DRIVER..."
/usr/libexec/nut/$DRIVER -D -a $DEVICE_NAME &
sleep 5
/usr/sbin/upsd -D &
exec /usr/sbin/upsmon -D
