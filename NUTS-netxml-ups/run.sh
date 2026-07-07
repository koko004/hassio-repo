#!/bin/bash

OPTIONS_FILE="/data/options.json"

DEVICE_NAME=$(jq --raw-output '.device_name' $OPTIONS_FILE)
DRIVER=$(jq --raw-output '.driver' $OPTIONS_FILE)
PORT=$(jq --raw-output '.port' $OPTIONS_FILE)
USERNAME=$(jq --raw-output '.username' $OPTIONS_FILE)
PASSWORD=$(jq --raw-output '.password' $OPTIONS_FILE)

cat << EOF > /etc/nut/ups.conf
[$DEVICE_NAME]
    driver = $DRIVER
    port = $PORT
    desc = "Eaton UPS"
EOF

cat << EOF > /etc/nut/upsd.conf
LISTEN 0.0.0.0 3493
EOF

cat << EOF > /etc/nut/upsd.users
[$USERNAME]
    password = $PASSWORD
    actions = SET
    instcmds = ALL
    upsmon = primary
EOF

cat << EOF > /etc/nut/upsmon.conf
MONITOR $DEVICE_NAME@localhost 1 $USERNAME $PASSWORD primary
SHUTDOWNCMD "/sbin/shutdown -h now"
POWERDOWNFLAG /etc/killpower
EOF

chmod 644 /etc/nut/*

echo "Starting driver: $DRIVER on $PORT"
/usr/libexec/nut/$DRIVER -D -a $DEVICE_NAME &

sleep 3

echo "Starting upsd"
/usr/sbin/upsd -D &

sleep 2

echo "Starting upsmon"
exec /usr/sbin/upsmon -D
