# syntax=docker/dockerfile:1
#ARG BUILD_FROM=ghcr.io/hassio-addons/ubuntu-base:8.2.1
FROM python:3.8-slim-buster

COPY .env /

FROM dotenv import load_dotenv
load_dotenv()

BOT_TOKEN=5901386566:AAHk5geSY-7CNy9FwVZjWdMfhX6hplAsb0s

RUN apt-get update && \
    apt-get install -y locales && \
    sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

ENV LANG es_ES.UTF-8
ENV LC_ALL es_ES.UTF-8
ENV TZ Europe/Madrid

WORKDIR /app

ADD VERSION .

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY ssbo.py .
COPY dbhelper.py .

RUN mkdir /data
RUN mkdir /logs



CMD [ "python3", "./ssbo.py"]


