# syntax=docker/dockerfile:1
FROM ghcr.io/home-assistant/base:latest

RUN \
  apk add --no-cache \
    python3 \
    py3-pip \
    py3-virtualenv \
    tzdata

RUN \
  apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

RUN apk del .build-deps

COPY ssbo.py .
COPY dbhelper.py .

RUN mkdir -p /data /logs

CMD ["python3", "./ssbo.py"]
