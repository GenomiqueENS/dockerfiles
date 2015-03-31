############################################################
# Dockerfile to build BWA container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler and perl stuff
RUN apt-get install --yes build-essential gcc-multilib apt-utils zlib1g-dev wget

# Get source code
WORKDIR /tmp

RUN wget -q http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.12.tar.bz2

RUN tar xjf bwa-0.7.12.tar.bz2

WORKDIR /tmp/bwa-0.7.12

# Patch Makefile
RUN sed -i 's/CFLAGS=\\t\\t-g -Wall -Wno-unused-function -O2/CFLAGS=-g -Wall -Wno-unused-function -O2 -static/' Makefile

# Compile
RUN make

RUN cp -p bwa /usr/local/bin

# Cleanup
RUN rm -rf /tmp/bwa-0.7.12

RUN apt-get clean

RUN apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev wget

WORKDIR /root
