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

# Download MACS2
ADD https://pypi.python.org/packages/source/M/MACS2/MACS2-2.1.0.20140616.tar.gz /tmp/

# Uncompress tar file
RUN tar xzf /tmp/*.tar.gz -C /tmp

# Compile and install MACS
RUN cd /tmp/MACS*/ && python setup.py install

# Cleanup
RUN apt-get clean
RUN rm -rf /tmp/MACS

# Default command to execute at startup of the container
CMD macs2
