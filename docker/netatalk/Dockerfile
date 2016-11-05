FROM rootlogin/fileserver-base:latest
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

ARG NETATALK_VERSION="3.1.10"
ARG BUILD_DEPS="build-essential libevent-dev libssl-dev libgcrypt11-dev libkrb5-dev libpam0g-dev libwrap0-dev libdb-dev libtdb-dev libmysqlclient-dev libavahi-client-dev libacl1-dev libldap2-dev libcrack2-dev systemtap-sdt-dev libdbus-1-dev libdbus-glib-1-dev libglib2.0-dev libtracker-sparql-1.0-dev libtracker-miner-1.0-dev file"

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ${BUILD_DEPS} \
    tracker \
    libevent-2.0 \
    libavahi-client3 \
    libevent-core-2.0 \
    libwrap0 \
    libtdb1 \
    libmysqlclient18 \
    libcrack2 \
    libdbus-glib-1-2 \
    libgssapi-krb5-2 \
  && cd /tmp \
  && wget "http://downloads.sourceforge.net/project/netatalk/netatalk/${NETATALK_VERSION}/netatalk-${NETATALK_VERSION}.tar.gz" -O /tmp/netatalk.tgz \
  && tar xvzf /tmp/netatalk.tgz \
  && cd /tmp/netatalk-${NETATALK_VERSION} \
  && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --with-init-style=debian-systemd \
    --without-libevent \
    --without-tdb \
    --with-cracklib \
    --enable-krbV-uam \
    --with-pam-confdir=/etc/pam.d \
    --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
    --with-tracker-pkgconfig-version=1.0 \
  && make \
  && make install \
  && DEBIAN_FRONTEND=noninteractive apt-get purge -y ${BUILD_DEPS} \
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /usr/share/icons \
  && rm -rf /usr/share/poppler \
  && rm -rf /usr/share/mime \
  && rm -rf /usr/share/GeoIP

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 548

ENTRYPOINT ["/usr/local/bin/tini", "-s", "-g", "--", "/opt/rootlogin-fileserver/run.sh"]

CMD ["/run.sh"]
