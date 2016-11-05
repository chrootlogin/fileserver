FROM rootlogin/fileserver-base:latest
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  samba \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/samba

EXPOSE 135
EXPOSE 139
EXPOSE 445

CMD ["/usr/sbin/smbd", "-s", "/etc/fileserver/smb.conf", "-F", "-S"]
