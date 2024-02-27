FROM ubuntu:22.04

LABEL de.manulix.image.authors="manuel.merkl@manulix.de"

WORKDIR /tmp

ENV SERVE_PATH=/
ENV PORT=4443

RUN apt-get update \

    # Upgrade
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \

    # Install dependencies
    && apt-get install git -y \

    # Download, Compile & Install MegaCMD

    # Install Dependencies
    && apt-get install autoconf libtool g++ \
    libcrypto++-dev libz-dev libsqlite3-dev \
    libssl-dev libcurl4-gnutls-dev libreadline-dev \
    libpcre++-dev libsodium-dev libc-ares-dev \
    libfreeimage-dev libavcodec-dev libavutil-dev \
    libavformat-dev libswscale-dev libmediainfo-dev \
    libzen-dev libuv1-dev -y \

    # Clone MEGAcmd Git Repository
    && git clone https://github.com/meganz/MEGAcmd.git \

    # Obtain the repository recursively
    && cd MEGAcmd && git submodule update --init --recursive

    # Building and installing MEGAcmd
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

    # Cleanup
RUN rm -r /tmp/MEGAcmd \
    && apt-get purge -y \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    
    # Create MEGA folder
    && mkdir /root/MEGA

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]