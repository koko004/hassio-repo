ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM $BUILD_FROM

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

ARG CLOUDFLARED_VERSION=2026.7.3
ARG CLOUDFLARED_BASE_URL="https://github.com/cloudflare/cloudflared/releases/download"

ENV VERSION=$CLOUDFLARED_VERSION
ENV WEBUI_PORT=${WEBUI_PORT:-14333}
ENV METRICS_ENABLE=${METRICS_ENABLE:-"false"}
ENV METRICS_PORT=${METRICS_PORT:-60123}

EXPOSE ${WEBUI_PORT}
EXPOSE ${METRICS_PORT}

USER root
WORKDIR /var/app

RUN apk add --no-cache \
    curl \
    nodejs \
    npm \
    && rm -rf /var/cache/apk/*

RUN case "$TARGETARCH" in \
        amd64) CLOUDFLARED_ARCH="amd64" ;; \
        arm64) CLOUDFLARED_ARCH="arm64" ;; \
        arm/v7) CLOUDFLARED_ARCH="arm" ;; \
        *) echo "Unsupported architecture: $TARGETARCH"; exit 1 ;; \
    esac && \
    CLOUDFLARED_URL="$CLOUDFLARED_BASE_URL/$CLOUDFLARED_VERSION/cloudflared-linux-$CLOUDFLARED_ARCH" && \
    curl -L --output /usr/local/bin/cloudflared "$CLOUDFLARED_URL" && \
    chmod +x /usr/local/bin/cloudflared && \
    cloudflared --version

VOLUME /config
VOLUME /root/.cloudflared

COPY app/backend /var/app/backend
COPY app/frontend /var/app/frontend

RUN cd /var/app/frontend && npm install && npm run build
RUN cd /var/app/backend && npm install

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]