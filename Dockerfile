FROM ubuntu:latest
MAINTAINER Nicolas Limage <github@xephon.org>
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
VOLUME /etc/nsd/zones
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nsd
RUN mkdir /run/nsd && chown nsd:nsd /run/nsd
COPY nsd.conf /etc/nsd/nsd.conf
COPY nsd-reload /usr/bin
RUN chmod 755 /usr/bin/nsd-reload
EXPOSE 53/udp 53/tcp
CMD ["/usr/sbin/nsd", "-d", "-u", "nsd"]
