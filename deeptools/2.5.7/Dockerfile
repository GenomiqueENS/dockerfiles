############################################################
# Dockerfile to build deeptools container image
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren

ARG PACKAGE_VERSION=2.5.7
ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_PACKAGES="zlib1g-dev libcurl4-nss-dev"


RUN apt-get update && \
    apt-get install --yes \
              $BUILD_PACKAGES \
              python-pip && \
    pip install --upgrade pip && \
    pip install deeptools==$PACKAGE_VERSION && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
