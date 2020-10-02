############################################################
# Dockerfile to build Cutadapt container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:20.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine, slemoine@biologie.ens.fr

ARG PACKAGE_VERSION=2.10
ARG BUILD_PACKAGES="build-essential"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install --yes $BUILD_PACKAGES && \
    apt install --yes python3-pip \
                      libpython3-dev && \
    pip3 install "cutadapt==$PACKAGE_VERSION" && \
    apt autoremove --purge --yes && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
