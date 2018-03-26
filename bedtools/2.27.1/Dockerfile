############################################################
# Dockerfile to build bedtools image
# Based on Ubuntu 16.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04  

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

ARG PACKAGE_VERSION=2.27.1
ARG BUILD_PACKAGES="git openssl python build-essential zlib1g-dev"
ARG DEBIAN_FRONTEND=noninteractive

# Update the repository sources list
RUN apt-get update && \
    apt-get install --yes \
              $BUILD_PACKAGES && \
    cd /tmp && \
    git clone https://github.com/arq5x/bedtools2.git && \
    cd bedtools2 && \
    git checkout v$PACKAGE_VERSION && \
    make && \
    mv bin/* /usr/local/bin && \
    cd / && \
    rm -rf /tmp/* && \
    apt remove --purge --yes \
              $BUILD_PACKAGES && \
    apt autoremove --purge --yes && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

