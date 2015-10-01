############################################################
# Dockerfile to build biopython container images
# Based on Ubuntu 
############################################################

# Set the base image to python official 2.7
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils

# Install python
RUN apt-get install --yes \
 python2.7

# Install Numpy and Scipy
RUN apt-get build-dep --yes python-biopython

# Install BioPython
RUN apt-get install --yes \
 python-biopython=1.63-1 \
 python-biopython-sql=1.63-1
