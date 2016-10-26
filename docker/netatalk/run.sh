#!/bin/bash

mkdir -p /var/run/dbus
rm -f /var/run/dbus/pid

exec dbus-daemon --system
exec netatalk -d
