############################################################
# Dockerfile to build bedtools 2.25.0 image
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04  

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Install libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
 build-essential \
 ca-certificates \
 perl \
 libbz2-dev \
 liblzma-dev \
 libncurses5-dev \
 libncursesw5-dev \
 zlib1g-dev \
 git \
 gnuplot-nox \
 gnuplot
RUN rm -rf /var/lib/apt/lists/*

# 

WORKDIR /usr/local
RUN git clone https://github.com/samtools/htslib.git
WORKDIR /usr/local/htslib
RUN git checkout 1.4.1
RUN make \
 && make install
WORKDIR /usr/local
RUN git clone https://github.com/samtools/samtools.git
WORKDIR /usr/local/samtools
RUN git checkout 1.4.1 
RUN make \
 && make install

# Cleanup
RUN apt-get clean

