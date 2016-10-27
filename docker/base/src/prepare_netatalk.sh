#!/bin/bash

if [ ! -f /etc/netatalk/afp.conf ]; then
  cp /opt/rootlogin-fileserver/etc/afp.conf /etc/netatalk/afp.conf
fi
