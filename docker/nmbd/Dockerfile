FROM rootlogin/fileserver-base:develop
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  samba \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/samba

EXPOSE 137/udp
EXPOSE 138/udp

CMD ["/usr/sbin/nmbd", "-s", "/etc/fileserver/smb.conf", "-F", "-S"]
