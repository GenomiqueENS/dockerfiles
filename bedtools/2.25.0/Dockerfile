############################################################
# Dockerfile to build bedtools 2.25.0 image
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04  

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler and basics
RUN apt-get install --yes \
 build-essential \
 libgcc1 \
 libc6 \
 libstdc++6 \
 gcc-multilib \
 apt-utils \
 unzip \
 zlib1g \
 zlib1g-dev \
 filo

# Install python
RUN apt-get install --yes \
 python2.7 \
 python2.7-dev \
 libpython2.7 \
 libpython2.7-dev
 
RUN ln -s /usr/bin/python2.7 /usr/bin/python

#Install bedtools
RUN apt-get install -y openssl \
 git

WORKDIR /usr/local/
RUN git clone https://github.com/arq5x/bedtools2.git
WORKDIR /usr/local/bedtools2
RUN git checkout v2.25.0 
RUN pwd 
RUN make

RUN ln -s /usr/local/bedtools2/bin/* /usr/local/bin/

# Cleanup
RUN apt-get clean

