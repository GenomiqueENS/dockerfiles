###########################################################
# Dockerfile to build rsem container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler, perl , R and stuff
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 zlib1g-dev \
 perl \
 perl-base \
 r-base \
 r-base-core \
 r-base-dev

#Install Bowtie 
RUN apt-get install --yes bowtie

# Install git
RUN apt-get install -y git

# Install STAR
WORKDIR /usr/local/
RUN pwd
RUN git clone https://github.com/bli25wisc/RSEM.git
WORKDIR /usr/local/RSEM
RUN pwd
RUN git checkout v1.2.19
RUN make 
RUN make ebseq
ENV PATH /usr/local/RSEM:$PATH

