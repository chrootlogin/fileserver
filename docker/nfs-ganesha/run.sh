#!/bin/bash

echo "Starting rpcbind..."
rpcbind
rpc.statd -L
rpc.idmapd

echo "Starting dbus..."
mkdir -p /var/run/dbus
rm -f /var/run/dbus/pid
dbus-daemon --system

echo "Starting NFS-Ganesha..."
exec /usr/bin/ganesha.nfsd -F -f /etc/fileserver/ganesha.conf
