# Set the base image to Ubuntu 16.04
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

ARG ALBACORE_VERSION=2.2.7
ARG BUILD_PACKAGES="wget apt-transport-https"
ARG DEBIAN_FRONTEND=noninteractive

# Install Albacore and its dependencies
RUN apt update && \
    apt install --yes $BUILD_PACKAGES && \
    wget -q -O- https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | apt-key add - && \
    echo "deb http://mirror.oxfordnanoportal.com/apt trusty-stable non-free" > /etc/apt/sources.list.d/nanoporetech.sources.list && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install --yes \
                      python3 \
                      python3-h5py \
                      python3-numpy \
                      python3-dateutil \
                      python3-pkg-resources \
                      python3-progressbar \
                      python3-setuptools \
                      libboost-program-options1.58.0 \
                      libboost-system1.58.0 \
                      libboost-python1.58.0 \
                      libboost-filesystem1.58.0 \
                      libboost-log1.58.0 \
                      libboost-thread1.58.0 \
                      libboost-date-time1.58.0 \
                      python3-ont-fast5-api \
                      libhdf5-cpp-11 && \
    wget -q https://mirror.oxfordnanoportal.com/software/analysis/python3-ont-albacore_${ALBACORE_VERSION}-1%7Exenial_amd64.deb && \
    dpkg -i python3-ont-albacore_*.deb && \
    rm python3-ont-albacore_*.deb && \
    apt remove --purge --yes \
              $BUILD_PACKAGES && \
    apt autoremove --purge --yes && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

