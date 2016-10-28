FROM rootlogin/fileserver-base:develop
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

ARG NFS_GANESHA_VERSION="2.4.0.4"
ARG BUILD_DEPS="build-essential"

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ${BUILD_DEPS} \
  && cd /tmp \
  && wget "https://github.com/nfs-ganesha/nfs-ganesha/archive/V${NFS_GANESHA_VERSION}.tar.gz" -O /tmp/nfs-ganesha.tgz \
  && tar xvzf /tmp/nfs-ganesha.tgz \
  && cd /tmp/nfs-ganesha-${NFS_GANESHA_VERSIONs} \
  && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --with-fsal=POSIX \
  && make \
  && make install \
  && DEBIAN_FRONTEND=noninteractive apt-get purge -y ${BUILD_DEPS} \
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

VOLUME /etc/netatalk

EXPOSE 548

CMD ["/bin/bash"]
