#############################################################
# Dockerfile to build rsem container images integrating STAR 
# Based on Ubuntu
#############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

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
 r-base-dev \
 git

# Compile and install STAR
WORKDIR /usr/local
RUN git clone https://github.com/alexdobin/STAR.git
WORKDIR /usr/local/STAR
RUN git checkout 2.5.1b 
WORKDIR /usr/local/STAR
RUN make STAR 
RUN ln -s ./STAR /usr/local/bin/STAR


#Install Bowtie 
RUN apt-get install --yes bowtie

# Install RSEM 
WORKDIR /usr/local/
RUN pwd
RUN git clone https://github.com/deweylab/RSEM.git
WORKDIR /usr/local/RSEM
RUN pwd
RUN git checkout v1.2.28
RUN make 
RUN make ebseq
ENV PATH /usr/local/RSEM:$PATH

# Cleanup                                                                                                                                                                                                        
RUN apt-get clean ; apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev vim-common git

