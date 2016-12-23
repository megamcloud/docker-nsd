FROM ubuntu:latest
MAINTAINER Nicolas Limage <github@xephon.org>
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
VOLUME /etc/nsd/zones
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nsd
ENV NSD_CONFDIR /etc/nsd
ENV NSD_RUNDIR /run/nsd
RUN mkdir $NSD_RUNDIR && chown nsd:nsd $NSD_RUNDIR
COPY nsd.conf $NSD_CONFDIR/nsd.conf
COPY nsd-reload nsd-genzoneconf nsd-start /usr/local/bin/
RUN chmod 755 /usr/local/bin/nsd-*
EXPOSE 53/udp 53/tcp
CMD ["/usr/local/bin/nsd-start"]
