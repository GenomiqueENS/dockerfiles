############################################################
# Dockerfile to build Matplotlib 1.4.3 (Python library
# container images.
#
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Alexandra Bomane <bomane@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install pip, Python and matplotlib required libraries
RUN apt-get update && apt-get install -y python python-dev python-pip \
    libxft-dev libfreetype6 libfreetype6-dev

# Install matplotlib
RUN pip install 'matplotlib==1.4.3'
