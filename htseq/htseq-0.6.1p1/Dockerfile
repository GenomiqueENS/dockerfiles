############################################################
# Dockerfile to build HTSeq container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update && \
    apt-get install --yes build-essential \
                          python2.7-dev \
                          python-numpy \
                          python-matplotlib \
                          python-pip \
                          zlib1g-dev && \
    apt-get clean

# Download and uncompress HTSeq archive
ADD HTSeq-0.6.1p1.tar.gz /tmp/

# Install HTSeq and pysam
RUN cd /tmp/* && \
    python setup.py build && \
    python setup.py install && \
    pip install 'pysam' && \
    rm -rf /tmp/*
