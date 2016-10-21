############################################################
# Dockerfile to build BWA 0.7.15 container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler and perl stuff
RUN apt-get install --yes build-essential gcc-multilib apt-utils zlib1g-dev wget

# Get source code from git
RUN apt-get install --yes git
WORKDIR /tmp
RUN git clone https://github.com/lh3/bwa.git
WORKDIR /tmp/bwa
RUN git checkout v0.7.15

# Compile
RUN make
RUN cp -p bwa /usr/local/bin

# Cleanup
RUN rm -rf /tmp/bwa
RUN apt-get clean
RUN apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev wget

