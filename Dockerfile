FROM ubuntu:22.04

LABEL de.manulix.image.authors="manuel.merkl@manulix.de"

WORKDIR /tmp

ENV SERVE_PATH=/
ENV PORT=4443

RUN apt update \

    # Upgrade
    && apt upgrade -y \
    && apt dist-upgrade -y \

    # Install dependencies
    && apt install git -y \

    # Download, Compile & Install MegaCMD

    # Install Dependencies
    && apt install autoconf libtool g++ \
    libcrypto++-dev libz-dev libsqlite3-dev \
    libssl-dev libcurl4-gnutls-dev libreadline-dev \
    libpcre++-dev libsodium-dev libc-ares-dev \
    libfreeimage-dev libavcodec-dev libavutil-dev \
    libavformat-dev libswscale-dev libmediainfo-dev \
    libzen-dev libuv1-dev -y \

    && apt install build-essential -y \

    # Clone MEGAcmd Git Repository
    && git clone https://github.com/meganz/MEGAcmd.git .\

    # Obtain the repository recursively
    && git submodule update --init --recursive

    # Building and installing MEGAcmd
RUN sh autogen.sh

RUN ./configure --without-freeimage

RUN make

RUN make install

    # Cleanup
RUN rm -r /tmp/* \
    && apt-get purge -y \
    && apt-get autoremove -y \
    && apt-get autoclean -y

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]