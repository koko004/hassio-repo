ARG BUILD_FROM
FROM $BUILD_FROM

# Copy data for add-on
COPY docker_run.sh /
RUN chmod a+x /docker_run.sh

CMD [ "/docker_run.sh" ]
