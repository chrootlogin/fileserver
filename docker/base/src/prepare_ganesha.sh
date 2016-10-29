#!/bin/bash

if [ ! -f /etc/fileserver/ganesha.conf ]; then
  cp /opt/rootlogin-fileserver/etc/ganesha.conf /etc/fileserver/ganesha.conf
fi
