############################################################
# Dockerfile to build HISAT container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler and perl stuff
RUN apt-get install --yes build-essential git

# Install HISAT
WORKDIR /tmp
RUN git clone https://github.com/infphilo/hisat.git
WORKDIR /tmp/hisat
RUN git checkout master

# Compile
RUN make
RUN cp -p hisat hisat-* /usr/local/bin

# Cleanup
RUN rm -rf /tmp/hisat
RUN apt-get clean
RUN apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev vim git

# Set default working path
WORKDIR /root

# Default command to execute at startup of the container
CMD hisat
