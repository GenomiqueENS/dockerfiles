############################################################
# Dockerfile to build MISO 0.5.3 container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler and python stuff, samtools and git
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 gfortran \ 
 apt-utils \
 python2.7 \
 python2.7-dev \
 libblas3 \ 
 liblapack3 \
 libc6 \
 cython \ 
 samtools \
 libbam-dev \
 python-pip \
 python-scipy \
 python-numpy \ 
 python-matplotlib \
 bedtools \
 wget \
 zlib1g-dev \ 
 tar \
 gzip

# Install fastmiso from git
WORKDIR /usr/local
RUN wget http://pypi.python.org/packages/source/m/misopy/misopy-0.5.3.tar.gz
RUN tar xvzf misopy-0.5.3.tar.gz
WORKDIR misopy-0.5.3
RUN pip install misopy
