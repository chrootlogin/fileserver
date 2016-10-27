#!/bin/bash

mkdir -p /var/run/dbus
rm -f /var/run/dbus/pid

dbus-daemon --system
exec netatalk -d -F /etc/netatalk/afp.conf
