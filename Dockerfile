FROM alpine:latest

# DocumentRoot for Apache
ENV DOCROOT=/var/www/html

RUN apk update \
  && apk add apache2 \
  && apk add curl \
  && sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/httpd.conf \
  && chgrp -R 0  /var/www/logs/ \
  && chmod g+xrw  /var/www/logs/

# Allows child images to inject their own content into DocumentRoot
ONBUILD COPY src/ ${DOCR /var/www/logs/error.logOOT}/
EXPOSE 80
# This stuff is needed to ensure a clean start
RUN rm -rf /run/httpd && mkdir /run/httpd
# Run as the root user
USER root
# Launch httpd
CMD /usr/sbin/httpd -D FOREGROUND
