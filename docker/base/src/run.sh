#!/bin/bash

if [ ! -f /etc/samba/smb.conf ]; then
  cp /opt/docker-samba/etc/smb.conf /etc/samba/smb.conf
fi

if [ ! -f /var/lib/extrausers/passwd ]; then
  touch /var/lib/extrausers/passwd
fi

if [ ! -f /var/lib/extrausers/shadow ]; then
  touch /var/lib/extrausers/shadow
fi

if [ ! -f /var/lib/extrausers/group ]; then
  touch /var/lib/extrausers/group
fi

if [ ! -f /var/lib/samba/.initialized ]; then
  echo "Initializing /var/lib/samba. Please be patient..."
  SAMBA_URI=$(apt-cache show samba  | grep "Filename:" | cut -f 2 -d " ")
  wget "http://ftp.debian.org/debian/${SAMBA_URI}" -O /tmp/samba.deb
  dpkg -x /tmp/samba.deb /tmp/samba
  cp -r /tmp/samba/var/lib/samba/* /var/lib/samba
  mkdir /var/lib/samba/private
  rm -rf /tmp/*
  touch /var/lib/samba/.initialized
fi

if [ "$1" == "manage" ]; then
  exec /opt/docker-samba/manage.sh "$@"
  exit
fi

exec "$@"
