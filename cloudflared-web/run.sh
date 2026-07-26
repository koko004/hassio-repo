#!/bin/bash

set -e

OPTIONS_FILE="/data/options.json"

TOKEN=$(jq --raw-output '.token // ""' $OPTIONS_FILE)
START=$(jq --raw-output '.start // false' $OPTIONS_FILE)
WEBUI_PORT=$(jq --raw-output '.webui_port // 14333' $OPTIONS_FILE)
METRICS_ENABLE=$(jq --raw-output '.metrics_enable // "false"' $OPTIONS_FILE)
METRICS_PORT=$(jq --raw-output '.metrics_port // 60123' $OPTIONS_FILE)
BASIC_AUTH_USER=$(jq --raw-output '.basic_auth_user // "admin"' $OPTIONS_FILE)
BASIC_AUTH_PASS=$(jq --raw-output '.basic_auth_pass // ""' $OPTIONS_FILE)
EDGE_BIND_ADDRESS=$(jq --raw-output '.edge_bind_address // ""' $OPTIONS_FILE)
GRACE_PERIOD=$(jq --raw-output '.grace_period // ""' $OPTIONS_FILE)
REGION=$(jq --raw-output '.region // ""' $OPTIONS_FILE)
RETRIES=$(jq --raw-output '.retries // ""' $OPTIONS_FILE)
EDGE_IP_VERSION=$(jq --raw-output '.edge_ip_version // ""' $OPTIONS_FILE)
PROTOCOL=$(jq --raw-output '.protocol // ""' $OPTIONS_FILE)

export WEBUI_PORT=$WEBUI_PORT
export METRICS_ENABLE=$METRICS_ENABLE
export METRICS_PORT=$METRICS_PORT

export BASIC_AUTH_USER=$BASIC_AUTH_USER
export BASIC_AUTH_PASS=$BASIC_AUTH_PASS

if [ -n "$EDGE_BIND_ADDRESS" ]; then
    export EDGE_BIND_ADDRESS=$EDGE_BIND_ADDRESS
fi

if [ -n "$GRACE_PERIOD" ]; then
    export GRACE_PERIOD=$GRACE_PERIOD
fi

if [ -n "$REGION" ]; then
    export REGION=$REGION
fi

if [ -n "$RETRIES" ]; then
    export RETRIES=$RETRIES
fi

if [ -n "$EDGE_IP_VERSION" ]; then
    export EDGE_IP_VERSION=$EDGE_IP_VERSION
fi

if [ -n "$PROTOCOL" ]; then
    export PROTOCOL=$PROTOCOL
fi

if [ "$START" = "true" ] && [ -n "$TOKEN" ]; then
    echo "Starting cloudflared tunnel..."
    cloudflared tunnel --config /config/config.yml run --token "$TOKEN" &
    CLOUDFLARED_PID=$!
    echo "Cloudflared started with PID $CLOUDFLARED_PID"
else
    echo "Tunnel not started (start=false or no token provided)"
fi

echo "Starting web UI on port $WEBUI_PORT..."
exec node /var/app/backend/app.js