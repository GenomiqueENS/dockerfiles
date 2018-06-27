############################################################
# Dockerfile to build image for BlacklistRemove module
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04  

# File Author / Maintainer
MAINTAINER Cedric Michaud

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

#Install bedtools version 2.25.0
RUN apt-get install -y openssl \
 git

WORKDIR /usr/local/
RUN git clone https://github.com/arq5x/bedtools2.git
WORKDIR /usr/local/bedtools2
RUN git checkout v2.25.0 
RUN pwd 
RUN make

RUN ln -s /usr/local/bedtools2/bin/* /usr/local/bin/

#Download hg38, hg19, mm9 and mm10 blacklists
RUN apt-get install wget
WORKDIR /
RUN mkdir blacklist_files
WORKDIR /blacklist_files
RUN wget https://raw.githubusercontent.com/ComputationalSystemsBiology/EoulsanDockerFiles/master/BlacklistRemove/Blacklist_files/hg19blacklist.bed
RUN wget https://raw.githubusercontent.com/ComputationalSystemsBiology/EoulsanDockerFiles/master/BlacklistRemove/Blacklist_files/mm10blacklist.bed
RUN wget https://raw.githubusercontent.com/ComputationalSystemsBiology/EoulsanDockerFiles/master/BlacklistRemove/Blacklist_files/mm9blacklist.bed
RUN wget https://raw.githubusercontent.com/ComputationalSystemsBiology/EoulsanDockerFiles/master/BlacklistRemove/Blacklist_files/hg38blacklist.bed

# Cleanup
RUN apt-get clean
