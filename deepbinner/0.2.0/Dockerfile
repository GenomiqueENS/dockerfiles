#############################################
# Dockerfile to build deepbinner image
# Based on Ubuntu 18.04
###############################################

### Goal ###
# Deepbinner is a tool for demultiplexing barcoded Oxford Nanopore sequencing reads
# It can be used in combination with Guppy

# Set the base image to Ubuntu 18.04
FROM ubuntu:18.04

# File Author / Maintainer
MAINTAINER Charlotte Berthelier <bertheli@biologie.ens.fr>

# Set non-interactive mode
ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install Deepbinner and its dependencies
RUN apt update && \
    apt install --yes git \
        python3.7 \
        python3-pkg-resources \
        python3-pip \
        python3-h5py \
        python3-numpy \
        python3-scipy \
        python3-six \
        build-essential && \
    apt update

RUN cd /tmp/ && git clone https://github.com/rrwick/Deepbinner.git 
RUN pip3 install /tmp/Deepbinner

RUN apt remove --purge --yes git build-essential && \
    apt autoremove --purge --yes

