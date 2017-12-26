###############################################
# Dockerfile to build minimap2 container image
# Based on Ubuntu 16.04
# Build with:
#   sudo docker build -t minimap2 .
###############################################

# Use ubuntu 16.04 base image
FROM ubuntu:16.04

# File author/maintainer info
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# set non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt update && \
    apt install --yes git \
    python3 \
    python3-pkg-resources \
    build-essential \
    zlib1g-dev 

WORKDIR /usr/local 
RUN git clone https://github.com/lh3/minimap2 
WORKDIR /usr/local/minimap2 
RUN pwd
RUN git checkout v2.3
RUN make && chmod 755 minimap2 
ENV PATH $PATH:/usr/local/minimap2

RUN apt remove --purge --yes git build-essential && \
    apt autoremove --purge --yes

# Set entrypoint so container can be used as executable
#ENTRYPOINT ["minimap2"]
#CMD ["-h"]
