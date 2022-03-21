FROM ubuntu AS build

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    bison curl flex g++ libboost-dev libxml2-dev libz-dev m4 make patch wget \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src
COPY z88dk.patch .

ARG Z88DK_VERSION=2.1

RUN wget https://github.com/z88dk/z88dk/releases/download/v${Z88DK_VERSION}/z88dk-src-${Z88DK_VERSION}.tgz \
  && tar xfz z88dk-src-${Z88DK_VERSION}.tgz \
  && patch -p0 < z88dk.patch \
  && cd z88dk \
  && BUILD_SDCC="1" BUILD_SDCC_HTTP="1" LDFLAGS="-s" ./build.sh -i /opt/z88dk \
  && make install DESTDIR=/opt/z88dk \
  && find /opt/z88dk/share -type f -exec chmod -x {} \;

FROM ubuntu

RUN apt-get update \
  && apt-get install -y m4 make \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/z88dk /opt/z88dk
ENV PATH /opt/z88dk/bin:$PATH
ENV ZCCCFG /opt/z88dk/share/z88dk/lib/config/
WORKDIR /workdir
