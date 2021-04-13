# Set the base image to Ubuntu 16.04 and NVIDIA GPU
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

ARG PACKAGE_VERSION=4.5.3
ARG BUILD_PACKAGES="wget apt-transport-https"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install --yes $BUILD_PACKAGES \
                      libzmq5 \
                      libcurl3 \
                      libhdf5-cpp-11 \
                      libssl1.0.0 \
                      libboost-atomic1.58.0 \
                      libboost-chrono1.58.0 \
                      libboost-date-time1.58.0 \
                      libboost-filesystem1.58.0 \
                      libboost-iostreams1.58.0 \
                      libboost-program-options1.58.0 \
                      libboost-regex1.58.0 \
                      libboost-system1.58.0 \
                      libboost-log1.58.0 && \
    cd /tmp &&\
    wget -q https://mirror.oxfordnanoportal.com/software/analysis/ont_guppy_${PACKAGE_VERSION}-1~xenial_amd64.deb && \
    dpkg -i --ignore-depends=nvidia-384,libcuda1-384 /tmp/ont_guppy_${PACKAGE_VERSION}-1~xenial_amd64.deb && \
    rm *.deb && \
    apt-get autoremove --purge --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

