FROM rootlogin/fileserver-base:develop
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

ARG NFS_GANESHA_BRANCH="master"
ARG BUILD_DEPS="build-essential git cmake bison flex libnfsidmap-dev libjemalloc-dev libkrb5-dev"

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ${BUILD_DEPS} \
    libnfsidmap2 \
    libjemalloc1 \
    libkrb5-3 \
    libgssapi-krb5-2 \
    nfs-common \
    dbus \
  && git clone --recursive https://github.com/nfs-ganesha/nfs-ganesha.git /tmp/nfs-ganesha \
  && cd /tmp/nfs-ganesha \
  && git checkout ${NFS_GANESHA_BRANCH} \
  && git submodule update \
  && mkdir /tmp/nfs-ganesha-build \
  && CMAKE_BUILD_TYPE=RELEASE cmake /tmp/nfs-ganesha/src \
  && make \
  && make install \
  && DEBIAN_FRONTEND=noninteractive apt-get purge -y ${BUILD_DEPS} \
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 548

CMD ["/run.sh"]
