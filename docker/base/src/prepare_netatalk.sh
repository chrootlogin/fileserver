#!/bin/bash

if [ ! -f /etc/fileserver/afp.conf ]; then
  cp /opt/rootlogin-fileserver/etc/afp.conf /etc/fileserver/afp.conf
fi
