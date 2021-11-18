FROM ubuntu:latest

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive
#ENV TZ=Europe/London

COPY scripts /var/spool/apt-mirror/

RUN echo \
 && apt-get -q -y update \
 && apt-get -q -y full-upgrade \
 && apt-get -q -y install apt-mirror \
                          wget \
                          nginx \
                          nano \
                          iproute2 \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && rm -f /etc/apt/mirror.list \
 && mv -f /var/spool/apt-mirror/wgetrc /etc/wgetrc \
 && mv /var/spool/apt-mirror/mirror.list /etc/apt/mirror.list

EXPOSE 80

VOLUME ["/var/spool/apt-mirror"]

ENTRYPOINT ["/var/spool/apt-mirror/entrypoint.sh"]
