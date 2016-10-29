FROM debian:jessie
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

ARG TINI_VERSION="v0.10.0"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/local/bin/tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /usr/local/bin/tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
  && gpg --verify /usr/local/bin/tini.asc \
  && rm -f /usr/local/bin/tini.asc \
  && chmod +x /usr/local/bin/tini

VOLUME /var/lib/extrausers
VOLUME /etc/fileserver

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  libnss-extrausers \
  wget \
  ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf

COPY src /opt/rootlogin-fileserver
RUN chmod +x /opt/rootlogin-fileserver/*.sh

ENTRYPOINT ["/usr/local/bin/tini", "--", "/opt/rootlogin-fileserver/run.sh"]
