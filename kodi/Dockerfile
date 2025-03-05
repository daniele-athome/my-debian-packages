FROM amd64/debian:trixie-slim

RUN mkdir /out && \
    echo 'deb-src http://ftp.debian.org/debian/ trixie main non-free non-free-firmware contrib' | tee /etc/apt/sources.list.d/debian-src.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y build-dep kodi && \
    apt-get clean

WORKDIR /out

COPY 0001-amd64-use-gles.patch .

RUN apt-get source kodi && \
    cd kodi-*/ && \
    patch -p1 < ../0001-amd64-use-gles.patch && \
    dpkg-buildpackage -rfakeroot -b -uc -us && \
    rm -rf /var/lib/apt/lists/*
