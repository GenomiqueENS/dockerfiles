############################################################
# Dockerfile to build htseq container image
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren

ARG PACKAGE_VERSION=0.9.1
ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_PACKAGES=""


RUN apt-get update && \
    apt-get install --yes \
              $BUILD_PACKAGES \
              python-pip && \
    pip install htseq==$PACKAGE_VERSION && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

#    pip install --upgrade pip && \

