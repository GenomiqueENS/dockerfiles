############################################################
# Dockerfile to build Bowtie 2 container images
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
RUN git clone https://github.com/BenLangmead/bowtie2.git
WORKDIR /tmp/bowtie2
RUN git checkout v2.2.4
# Patch Makefile
RUN sed -i 's/ifneq (,$(findstring 13,$(shell uname -r)))/ifneq (,$(findstring Darwin 13,$(shell uname -sr)))/' Makefile
RUN sed -i 's/RELEASE_FLAGS = -O3 -m64 $(SSE_FLAG) -funroll-loops -g3/RELEASE_FLAGS = -O3 -m64 $(SSE_FLAG) -funroll-loops -g3 -static/' Makefile
# Compile
RUN make
RUN cp -p bowtie2 bowtie2-* /usr/local/bin
# Cleanup
RUN rm -rf /tmp/bowtie2
RUN apt-get clean
RUN apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev vim git
WORKDIR /root
