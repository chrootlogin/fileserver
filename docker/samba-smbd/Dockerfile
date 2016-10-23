FROM rootlogin/samba-base:latest
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

EXPOSE 445
EXPOSE 139
EXPOSE 135

CMD ["/usr/sbin/smbd", "-F", "-S"]
