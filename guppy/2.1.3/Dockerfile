# Set the base image to Ubuntu 14.04
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Charlotte Berthelier <bertheli@biologie.ens.fr>

ARG PACKAGE_VERSION=2.1.3
ARG BUILD_PACKAGES="wget apt-transport-https"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt-get install --yes $BUILD_PACKAGES && \
    cd /tmp && \
    wget -q http://outils.genomique.biologie.ens.fr/leburon/downloads/nanopore/ont-guppy-cpu_2.1.3-1~trusty_amd64.deb && \
    apt-get install --yes libcurl4-openssl-dev libssl-dev libhdf5-7 libboost-regex1.54.0 libboost-log1.54.0 libzmq3 libboost-atomic1.54.0 libboost-chrono1.54.0 libboost-date-time1.54.0 libboost-filesystem1.54.0 libboost-program-options1.54.0 && \
    dpkg -i *.deb && \
    rm *.deb && \
    apt-get remove --purge --yes && \
    apt-get autoremove --purge --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
