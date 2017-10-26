###########################################################
# Dockerfile to build AlignQC container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Install dependancies

RUN apt-get update

RUN apt install --yes \
 python2.7 \
 python-pip \
 r-base \
 r-base-core \ 
 r-base-dev \
 git

RUN pip install --upgrade pip
RUN pip install seq-tools==1.0.7

# Install AlignQC 
WORKDIR /usr/local
RUN git clone https://github.com/jason-weirather/AlignQC.git
WORKDIR /usr/local/AlignQC
RUN git checkout v2.0.4

ENV PATH /usr/local/AlignQC/bin:${PATH}
RUN apt autoremove --yes --purge \
 && apt clean

