# syntax=docker/dockerfile:1
ARG BUILD_FROM=ghcr.io/hassio-addons/ubuntu-base:latest
FROM ${BUILD_FROM}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    locales \
    python3 \
    python3-pip \
    python3-venv && \
    sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG es_ES.UTF-8
ENV LC_ALL es_ES.UTF-8
ENV TZ Europe/Madrid

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

COPY ssbo.py .
COPY dbhelper.py .

RUN mkdir -p /data /logs

CMD ["python3", "./ssbo.py"]
