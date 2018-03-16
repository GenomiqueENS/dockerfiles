###############################################
# Dockerfile to build minimap2 container image
# Based on Ubuntu 16.04
# Build with:
#   sudo docker build -t minimap2 .
###############################################

# Use ubuntu 16.04 base image
FROM ubuntu:16.04

# File author/maintainer info
MAINTAINER Bérengère Laffay <laffay@biologie.ens.fr>

# set non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt update && \
    apt install --yes git \
                      bzip2 \
                      curl && \
    cd /tmp && \
    git clone https://github.com/lh3/minimap2 && \
    cd minimap2 && \
    git checkout v2.9 && \
    cd .. && \
    curl -L https://github.com/attractivechaos/k8/releases/download/v0.2.4/k8-0.2.4.tar.bz2 | tar -jxf - && \
    cp -p k8-*/k8-`uname -s` /usr/local/bin/k8 && \
    cp -p minimap2/misc/paftools.js /usr/local/bin/ && \
    rm -rf /tmp/* && \
    apt remove --purge --yes git curl bzip2 && \
    apt autoremove --purge --yes && \
    apt clean

# Set entrypoint so container can be used as executable
ENTRYPOINT ["paftools.js"]
