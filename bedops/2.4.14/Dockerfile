############################################################
# Dockerfile to build bedops 2.4.14 container images
# Based on Ubuntu
############################################################


# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler and perl stuff
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 zlib1g-dev \
 vim-common \
 wget

# Install Samtools
RUN apt-get install  --yes \
 libbam-dev \
 samtools

RUN ln -s /usr/lib/libbam.a /usr/include/samtools/libbam.a

ENV SAMTOOLS /usr/include/samtools

# Install bedops 2.4.14
WORKDIR /usr/local/
RUN mkdir bedops_v2.4.1
WORKDIR /usr/local/bedops_v2.4.1
RUN wget https://github.com/bedops/bedops/releases/download/v2.4.14/bedops_linux_x86_64-v2.4.14.tar.bz2
RUN tar xjf bedops_linux_x86_64-v2.4.14.tar.bz2 
RUN ls
WORKDIR /usr/local/bedops_v2.4.1/bin
RUN cp ./* /usr/local/bin/


# Cleanup                                                                                                                                                                                                                                                                                                             
RUN rm /usr/local/bedops_v2.4.1/bedops_linux_x86_64-v2.4.14.tar.bz2
RUN apt-get clean 
RUN apt-get remove --yes --purge build-essential wget gcc-multilib apt-utils zlib1g-dev vim-common 
