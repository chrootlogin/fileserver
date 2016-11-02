#!/bin/bash

echo "Starting dbus..."
mkdir -p /var/run/dbus
rm -f /var/run/dbus/pid
dbus-daemon --system

echo "Starting netatalk..."
exec netatalk -d -F /etc/fileserver/afp.conf
