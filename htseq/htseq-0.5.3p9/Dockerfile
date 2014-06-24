############################################################
# Dockerfile to build HTSeq container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install Latex
RUN apt-get install --yes build-essential python2.7-dev python-numpy python-matplotlib

# Download and uncompress HTSeq archive
ADD HTSeq-0.5.3p9.tar.gz /tmp/

# Install HTSeq
RUN cd /tmp/* && python setup.py build && python setup.py install

# Cleanup
RUN apt-get clean
RUN rm -rf /tmp/*
