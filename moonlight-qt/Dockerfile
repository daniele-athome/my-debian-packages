
# Use latest compatible Debian version
FROM amd64/debian:bookworm-slim

COPY 0001-custom-repo-version.patch /tmp/

# Checkout Moonlight-packaging
RUN mkdir -p /opt/scripts && \
    mkdir /out && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install -y git ca-certificates patch && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/cgutman/moonlight-packaging && \
    cd moonlight-packaging && \
    patch -p1 < /tmp/0001-custom-repo-version.patch && \
    rm -f /tmp/0001-custom-repo-version.patch && \
    git submodule update --init --recursive && \
    mv debian /opt/

WORKDIR /moonlight-packaging

# Copied from Dockerfile.amd64.buster and slightly changed by changing COPY to RUN mv
### start ###
ENV TARGET=desktop
ENV DISTRO=bookworm
ENV GIT_REPO=${GIT_REPO}
ENV COMMIT=${COMMIT}

RUN mv scripts/install-base-deps.sh /opt/scripts/
RUN /bin/bash -c /opt/scripts/install-base-deps.sh && \
    apt-get install -y --no-install-recommends build-essential libwayland-dev wayland-protocols libva-dev libvdpau-dev && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN mv dav1d /opt/dav1d
RUN mv FFmpeg /opt/FFmpeg
RUN mv nv-codec-headers /opt/nv-codec-headers
RUN mv SDL2 /opt/SDL2
RUN mv SDL_ttf /opt/SDL_ttf

RUN mv scripts/build-deps.sh /opt/scripts/
RUN /bin/bash -c /opt/scripts/build-deps.sh

RUN mv scripts/build-package.sh /opt/scripts/
### end ###

# override this with --build-arg
ARG DEBEMAIL="Debian Custom Package <debian@custom.pkg>"
ENV DEBEMAIL=${DEBEMAIL}
COPY --chmod=775 setup.sh /opt/setup.sh
RUN /bin/sh -c 'cd /opt && ./setup.sh'

# Change build-command from Dockerfile to RUN-command
RUN /bin/bash -c /opt/scripts/build-package.sh
