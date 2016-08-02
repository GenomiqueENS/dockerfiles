#########################################
# Dockerfile to build Ribomap 1.2 images
# Based on Ubuntu 14.04
########################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Alexandra Bomane <alexandra.bomane@laposte.net>

# Update repository source list
RUN apt-get update

# Install wget
RUN apt-get install --yes wget

# Install Ribomap
RUN wget https://github.com/Kingsford-Group/ribomap/releases/download/v1.2/ribomap-linux.tar.gz
RUN tar xzvf ribomap-linux.tar.gz
RUN rm ribomap-linux.tar.gz

# Add ribomap to PATH
ENV PATH /ribomap-linux/bin:$PATH
ENV PATH /ribomap-linux/scripts:$PATH

# Add libs
WORKDIR /ribomap-linux/lib
RUN cp * /usr/lib/x86_64-linux-gnu

## Upgrade libstdc++.so.6
RUN apt-get install --yes software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get install --yes libstdc++6

WORKDIR /

# Add script run_ribomap_for_riboproanalysis.sh
ADD run_ribomap_for_riboproanalysis.sh /ribomap-linux/scripts

# Clean
RUN  apt-get clean ; apt-get remove --yes --purge build-essential
