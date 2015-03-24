############################################################
# Dockerfile to build Bowtie container images
# Based on Ubuntu
############################################################
# Set the base image to Ubuntu
FROM ubuntu:12.04
# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>
# Update the repository sources list
RUN apt-get update
# Install compiler and perl stuff
RUN apt-get install --yes build-essential gcc-multilib apt-utils zlib1g-dev git
# Install STAR
WORKDIR /tmp
RUN git clone https://github.com/BenLangmead/bowtie.git
WORKDIR /tmp/bowtie
RUN git checkout v1.1.1
# Patch Makefile
RUN sed -i 's/ifneq (,$(findstring 13,$(shell uname -r)))/ifneq (,$(findstring Darwin 13,$(shell uname -sr)))/' Makefile
RUN sed -i 's/EXTRA_CFLAGS =/EXTRA_CFLAGS = -static/' Makefile
RUN sed -i 's/EXTRA_CXXFLAGS =/EXTRA_CXXFLAGS = -static/' Makefile
# Compile
RUN make
RUN cp -p bowtie bowtie-* /usr/local/bin
# Cleanup
RUN rm -rf /tmp/bowtie
RUN apt-get clean
RUN apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev vim git
WORKDIR /root
