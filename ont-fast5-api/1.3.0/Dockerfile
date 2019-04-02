############################################################
# Dockerfile to build ont-fast5-api container image
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Charlotte Berthelier

ARG PACKAGE_VERSION=1.3.0
ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_PACKAGES=""


RUN apt-get update && \
    apt-get install --yes \
              $BUILD_PACKAGES \
              python-pip && \
    pip install ont-fast5-api==$PACKAGE_VERSION && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
