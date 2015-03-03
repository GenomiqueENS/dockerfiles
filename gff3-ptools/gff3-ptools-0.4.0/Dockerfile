############################################################
# Dockerfile to build gff3-pltools container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler and stuff
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 git \
 xdg-utils \
 libcurl3 \
 vim \
 wget \
 rake 

# install DMD
WORKDIR /tmp
RUN wget http://downloads.dlang.org/releases/2014/dmd_2.066.0-0_amd64.deb
RUN dpkg -i dmd_2.066.0-0_amd64.deb

# Download gff3-pltools sources 
WORKDIR /usr/local/
RUN git clone https://github.com/mamarjan/gff3-pltools.git
WORKDIR /usr/local/gff3-pltools
RUN git checkout v0.4.0

# Compile and install gff3-pltools
#RUN export DC="gdc";rake utilities
RUN rake utilities
ENV PATH /usr/local/gff3-pltools/bin:$PATH


