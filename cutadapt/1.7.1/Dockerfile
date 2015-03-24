############################################################
# Dockerfile to build Cutadapt 1.7.1 container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Alexandra Bomane, bomane@biologie.ens.fr

# Update the repository sources list
RUN apt-get update

# Install pip and cutadapt required libraries 
RUN apt-get --yes install python-pip libpython2.7-dev

# Install cutadapt
RUN pip install 'cutadapt==1.7.1'
