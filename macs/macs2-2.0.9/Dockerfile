############################################################
# Dockerfile to build MACS container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install python, numpy and dependancies to build MACS
RUN apt-get install --yes build-essential git python python-numpy python-dev cython

# Clone MACS repository and checkout the requested tag
RUN cd /tmp && git clone https://github.com/taoliu/MACS.git && cd MACS && git checkout v2.0.9

# Compile and install MACS
RUN cd /tmp/MACS && python setup.py install

# Cleanup
RUN apt-get clean
RUN rm -rf /tmp/MACS

# Default command to execute at startup of the container
CMD macs2
