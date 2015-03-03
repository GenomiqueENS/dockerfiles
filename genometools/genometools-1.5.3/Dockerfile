############################################################
# Dockerfile to build genometools container images
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
 wget 

# Download genometools sources 
WORKDIR /tmp
RUN wget http://genometools.org/pub/genometools-1.5.3.tar.gz

# Untar source
RUN tar xzf genometools-1.5.3.tar.gz \ 
 && rm ./genometools-1.5.3.tar.gz

# Compile and install genometools
WORKDIR /tmp/genometools-1.5.3/
RUN pwd 
RUN make 64bit=yes cairo=no install



