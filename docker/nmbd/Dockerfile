FROM rootlogin/fileserver-base:latest
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  samba \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/samba
VOLUME /etc/samba

EXPOSE 137/udp
EXPOSE 138/udp

CMD ["/usr/sbin/nmbd", "-F", "-S"]
