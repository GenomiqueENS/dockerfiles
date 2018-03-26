############################################################
# Dockerfile to build subread container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren

ARG PACKAGE_VERSION=0.5.3
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --yes python-pip && \
    pip install --upgrade pip && \
    pip install umi_tools==$PACKAGE_VERSION && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
