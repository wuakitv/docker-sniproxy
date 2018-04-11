FROM debian:jessie
MAINTAINER Carles Amigó, carles.amigo@rakuten.com

ENV SNIPROXY_VERSION=0.5.0

RUN apt-get update && apt-get install -y \
      autotools-dev \
      cdbs \
      curl \
      debhelper \
      dh-autoreconf \
      dpkg-dev \
      gettext \
      libev-dev \
      libpcre3-dev \
      libudns-dev \
      pkg-config \
      fakeroot \
      devscripts \
      && \
    mkdir -p /src/sniproxy && \
    cd /src/sniproxy && \
    curl -L https://github.com/dlundquist/sniproxy/archive/${SNIPROXY_VERSION}.tar.gz | tar xvz --strip=1 && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    strip /usr/sbin/sniproxy && \
    cd / && \
    rm -rf /src && \
    apt-get purge --auto-remove -y \
      autotools-dev \
      cdbs \
      curl \
      debhelper \
      dh-autoreconf \
      dpkg-dev \
      gettext \
      libev-dev \
      libpcre3-dev \
      libudns-dev \
      pkg-config \
      fakeroot \
      devscripts \
      && \
    apt-get install -y \
      libev4 \
      libudns0 \
      && \
    rm -rf /usr/share/doc/* && \
    rm -rf /usr/share/info/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
