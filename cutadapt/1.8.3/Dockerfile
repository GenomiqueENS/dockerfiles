############################################################
# Dockerfile to build Cutadapt 1.8.3 container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine, slemoine@biologie.ens.fr

# Update the repository sources list and install essential libraries
RUN apt-get update && apt-get install --yes \
    build-essential

# Install pip and cutadapt required libraries
RUN apt-get install --yes \
        python-pip \
        libpython2.7-dev

# Install cutadapt
RUN pip install 'cutadapt==1.8.3'


# Clean
RUN  apt-get clean ; apt-get remove --yes --purge build-essential


