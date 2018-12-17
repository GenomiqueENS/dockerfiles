# Set the base image to Ubuntu 16.04
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Charlotte Berthelier <bertheli@biologie.ens.fr>

ARG PACKAGE_VERSION=2.1.3
ARG BUILD_PACKAGES="wget apt-transport-https"
ARG DEBIAN_FRONTEND=noninteractive


# Install Albacore and its dependencies
RUN apt update && \
    apt-get install --yes $BUILD_PACKAGES

#RUN wget -q https://mirror.oxfordnanoportal.com/software/analysis/ont-guppy-cpu_2.1.3_linux64.tar.gz && \
#    tar -zxf ont-guppy-cpu_2.1.3_linux64.tar.gz

RUN wget -q -O- https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | apt-key add - && \
    echo "deb http://mirror.oxfordnanoportal.com/apt xenial-stable non-free" > /etc/apt/sources.list.d/nanoporetech.sources.list && \
    apt update

RUN apt-get install --yes ont-guppy && \
    apt remove --purge --yes && \
    apt autoremove --purge --yes && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
