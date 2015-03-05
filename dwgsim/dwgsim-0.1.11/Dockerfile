############################################################
# Dockerfile to build dwgsim container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 zlib1g \ 
 zlib1g-dev \ 
 libncurses5 \ 
 libncurses5-dev \ 
 wget

RUN apt-get install -y git
WORKDIR /usr/local 
RUN git clone https://github.com/nh13/DWGSIM.git 
WORKDIR /usr/local/DWGSIM
RUN git submodule init
RUN git submodule update
RUN make
RUN ln -s /usr/local/DWGSIM/dwgsim /usr/local/bin/dwgsim
RUN ln -s /usr/local/DWGSIM/dwgsim_eval /usr/local/bin/dwgsim_eval
RUN ln -s /usr/local/DWGSIM/dwgims_pileup_eval.pl /usr/local/bin/dwgims_pileup_eval.pl

RUN apt-get clean 

