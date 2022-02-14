FROM ubuntu:latest

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive
#ENV TZ=Europe/London

COPY scripts /var/spool/apt-mirror/

RUN apt-get -q -y update
RUN apt-get -q -y full-upgrade
RUN apt-get -q -y install \
    apt-mirror \
    wget \
    nginx \
    nano \
    iproute2
RUN apt-get -q -y clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm -f /etc/apt/mirror.list
RUN mv -f /var/spool/apt-mirror/wgetrc /etc/wgetrc
RUN mv /var/spool/apt-mirror/mirror.list /etc/apt/mirror.list
RUN touch /var/spool/apt-mirror/sync

EXPOSE 80

VOLUME ["/var/spool/apt-mirror"]

ENTRYPOINT ["/var/spool/apt-mirror/entrypoint.sh"]
