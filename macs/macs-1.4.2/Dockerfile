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

# Install Latex
RUN apt-get install --yes python

# Download MACS
ADD https://github.com/downloads/taoliu/MACS/macs_1.4.2_python2.7.deb /tmp/

# Install MACS
RUN dpkg -i /tmp/*.deb

# Cleanup
RUN apt-get clean
RUN rm /tmp/*.deb

# Default command to execute at startup of the container
CMD macs14
