###############################################
# Dockerfile to build poretools container image
# Based on Ubuntu 14.04
# Build with:
#   sudo docker build -t poretools .
###############################################

# Use ubuntu 16.04 base image
FROM ubuntu:16.04

# File author/maintainer info
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# set non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt update && \
    apt install --yes git python3 python3-pkg-resources build-essential && \
    cd /tmp && \
    git clone https://github.com/rrwick/Porechop.git && \
    cd /tmp/Porechop && python3 setup.py install && \
    rm -rf /tmp/Porechop && \
    apt remove --purge --yes git build-essential && \
    apt autoremove --purge --yes

# Set entrypoint so container can be used as executable
ENTRYPOINT ["porechop"]
CMD ["-h"]
