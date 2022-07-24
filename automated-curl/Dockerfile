ARG BUILD_FROM
FROM $BUILD_FROM


COPY pihole.sh /
RUN \
  chmod +x pihole.sh \
  
CMD [ "./pihole.sh" ]

