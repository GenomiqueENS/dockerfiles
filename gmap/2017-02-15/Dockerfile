###########################################################
# Dockerfile to build gmap container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Aurélien Birer <birer@biologie.ens.fr>

# Update compiler + mercurial
RUN apt update && \
    apt install --yes \
          make \
          g++ \
          wget \
          perl && \
    cd /tmp && \
    wget http://research-pub.gene.com/gmap/src/gmap-gsnap-2017-02-15.tar.gz && \
    tar xzf gmap-gsnap-*.tar.gz && \
    cd /tmp/gmap-* && \
    ./configure --prefix=/usr/local && \
    make && \
    make check && \
    make install && \
    rm -rf /tmp/* && \
    apt remove --purge --yes \
          make \
          g++ \
          wget && \
    apt autoremove --purge --yes
         
