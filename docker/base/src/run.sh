#!/bin/bash

if [ ! -f /var/lib/extrausers/passwd ]; then
  touch /var/lib/extrausers/passwd
fi

if [ ! -f /var/lib/extrausers/shadow ]; then
  touch /var/lib/extrausers/shadow
fi

if [ ! -f /var/lib/extrausers/group ]; then
  touch /var/lib/extrausers/group
fi

if [ $(dpkg-query -W -f='${Status}' samba 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
  exec /opt/rootlogin-fileserver/prepare_samba.sh
fi

if [ "$1" == "manage" ]; then
  exec /opt/rootlogin-fileserver/manage.sh "$@"
  exit
fi

exec "$@"
