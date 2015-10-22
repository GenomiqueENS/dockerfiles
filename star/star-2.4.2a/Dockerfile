###########################################################
# Dockerfile to build star container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

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
WORKDIR /tmp 
RUN git clone https://github.com/alexdobin/STAR.git
WORKDIR /tmp/STAR
RUN git checkout STAR_2.4.2a
WORKDIR /tmp/STAR/source
RUN make STAR 
RUN mv STAR /usr/local/bin/

# Cleanup                                                                                                                                                                                                                                                                                                             
RUN rm -rf /tmp/STAR ; apt-get clean ; apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev vim-common git
