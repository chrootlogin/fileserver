FROM rootlogin/samba-base:latest
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

EXPOSE 137/udp
EXPOSE 138/udp

CMD ["/usr/sbin/nmbd", "-F", "-S"]
