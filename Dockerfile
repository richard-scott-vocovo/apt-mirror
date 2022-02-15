FROM ubuntu:latest

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive
#ENV TZ=Europe/London

COPY scripts /root/

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
RUN mv -f /root/wgetrc /etc/wgetrc
RUN mv /root/mirror.list /etc/apt/mirror.list
RUN touch /var/spool/apt-mirror/sync

EXPOSE 80

VOLUME ["/var/spool/apt-mirror"]

ENTRYPOINT ["/root/entrypoint.sh"]
