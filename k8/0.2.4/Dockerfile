# Set the base image to Ubuntu 18.04
FROM ubuntu:18.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

ARG VERSION=0.2.4
ARG BUILD_PACKAGES="wget apt-transport-https"
ARG DEBIAN_FRONTEND=noninteractive

# Install Albacore and its dependencies
RUN apt update && \
    apt install --yes $BUILD_PACKAGES && \
    apt install --yes libv8-dev && \
    cd /tmp  && \
    wget https://github.com/attractivechaos/k8/releases/download/v$VERSION/k8-$VERSION.tar.bz2 && \
    tar -jxf k8-$VERSION.tar.bz2 && \
    cp k8-0.2.4/k8-`uname -s` /usr/local/bin/k8 && \
    apt remove --purge --yes \
              $BUILD_PACKAGES && \
    apt autoremove --purge --yes && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

