# syntax=docker/dockerfile:1
ARG BUILD_FROM=ghcr.io/hassio-addons/ubuntu-base:8.2.1
FROM python:3.8-slim-buster



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
# Copy root filesystem
COPY rootfs /

# Copy data for add-on
COPY run.sh /
#RUN chmod a+x /run.sh
RUN chmod +x /run.sh
CMD [ "/run.sh" ]
