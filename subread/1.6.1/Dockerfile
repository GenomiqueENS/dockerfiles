############################################################
# Dockerfile to build subread container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine

ARG PACKAGE_VERSION=1.6.1
ARG BUILD_PACKAGES="build-essential wget zlib1g-dev"
ARG DEBIAN_FRONTEND=noninteractive

# Update the repository sources list
RUN apt-get update && \
    apt-get install --yes \
              $BUILD_PACKAGES && \
    cd /tmp && \
    wget -q https://downloads.sourceforge.net/project/subread/subread-${PACKAGE_VERSION}/subread-${PACKAGE_VERSION}-source.tar.gz && \
    tar -xzf subread-${PACKAGE_VERSION}-source.tar.gz && \
    cd subread-${PACKAGE_VERSION}-source/src && \
    make -f Makefile.Linux && \
    cd ../bin && \
    mv utilities/* . && \
    rmdir utilities && \
    mv * /usr/local/bin/ && \
    cd / && \
    rm -rf /tmp/* && \
    apt remove --purge --yes \
              $BUILD_PACKAGES && \
    apt autoremove --purge --yes && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
