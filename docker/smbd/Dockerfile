FROM rootlogin/samba-base:latest
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

EXPOSE 135
EXPOSE 139
EXPOSE 445

CMD ["/usr/sbin/smbd", "-F", "-S"]
