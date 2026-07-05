#!/bin/bash
OPTIONS_FILE="/data/options.json"

# Leer configuración desde el JSON de Home Assistant
DEVICE_NAME=$(jq --raw-output '.device_name' $OPTIONS_FILE)
DRIVER=$(jq --raw-output '.driver' $OPTIONS_FILE)
PORT=$(jq --raw-output '.port' $OPTIONS_FILE)
USERNAME=$(jq --raw-output '.username' $OPTIONS_FILE)
PASSWORD=$(jq --raw-output '.password' $OPTIONS_FILE)

echo "[INFO] Iniciando script de arranque..."
echo "[INFO] Verificando driver: /usr/libexec/nut/$DRIVER"

# Verificación de seguridad: si no existe, el script avisa y para
if [ ! -f "/usr/libexec/nut/$DRIVER" ]; then
    echo "[ERROR] El driver $DRIVER no se encuentra en /usr/libexec/nut/"
    echo "[DEBUG] Contenido de la carpeta:"
    ls -l /usr/libexec/nut/
    exit 1
fi

# Configuración de archivos de NUT
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

# Permisos
chmod 640 /etc/nut/*

# Ejecución
echo "[INFO] Lanzando driver..."
/usr/libexec/nut/$DRIVER -D -a $DEVICE_NAME &
sleep 5
echo "[INFO] Lanzando upsd..."
/usr/sbin/upsd -D &
sleep 2
echo "[INFO] Lanzando upsmon..."
exec /usr/sbin/upsmon -D
