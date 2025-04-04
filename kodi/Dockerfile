FROM amd64/debian:trixie-slim

COPY sources.list /etc/apt/sources.list.d/debian-other.list

RUN mkdir /out && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y build-dep kodi && \
    DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install devscripts && \
    apt-get clean

WORKDIR /out

COPY 0001-amd64-use-gles.patch .

# override this with --build-arg
ARG DEBEMAIL="Debian Custom Package <debian@custom.pkg>"
ENV DEBEMAIL=${DEBEMAIL}
RUN apt-get source kodi && \
    cd kodi-*/ && \
    dch --local "+custom" -p "Non-maintainer configuration release" && \
    patch -p1 < ../0001-amd64-use-gles.patch && \
    dpkg-buildpackage -rfakeroot -b -uc -us && \
    rm -rf /var/lib/apt/lists/*
