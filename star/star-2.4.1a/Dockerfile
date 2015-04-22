###########################################################
# Dockerfile to build star container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update && apt-get install --yes \
    build-essential \
    gcc-multilib \
    apt-utils \
    zlib1g-dev \
    vim-common \
    git

# Compile and install STAR
RUN cd /tmp && \
    git clone https://github.com/alexdobin/STAR.git && \
    cd STAR && \
    git checkout STAR_2.4.1a && \
    cd source && \
    make STARstatic && \
    mv STARstatic /usr/local/bin/STAR

# Cleanup                                                                                                                                                                                                                                                                                                             
RUN rm -rf /tmp/STAR ; apt-get clean ; apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev vim-common git
