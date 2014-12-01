###########################################################
# Dockerfile to build eXpress container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler, perl and stuff
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 zlib1g-dev \
 wget

# Get express
WORKDIR /usr/local/
RUN pwd
RUN wget http://bio.math.berkeley.edu/eXpress/downloads/express-1.5.1/express-1.5.1-src.tgz
RUN tar -xzf express-1.5.1-src.tgz
RUN rm express-1.5.1-src.tgz

# Install CMake
RUN apt-get install -y \
 cmake

# Install git
RUN apt-get install -y \
 git

# Install BamTools
WORKDIR /usr/local/express-1.5.1-src
RUN pwd 
RUN git clone https://github.com/pezmaster31/bamtools.git

WORKDIR /usr/local/express-1.5.1-src/bamtools
RUN pwd 
RUN git checkout v2.3.0 
RUN mkdir build
WORKDIR /usr/local/express-1.5.1-src/bamtools/build
RUN cmake .. \
 && make

# Install BOOST et bjam
RUN apt-get install -y \
 libboost1.48-dev \ 
 libboost1.48-all-dev 
 

# Install eXpress
WORKDIR /usr/local/express-1.5.1-src
RUN pwd 
RUN mkdir build
WORKDIR /usr/local/express-1.5.1-src/build
RUN cmake .. \
 && make \
 && make install

ENV PATH /usr/local/express-1.5.1-src/build/express:$PATH


