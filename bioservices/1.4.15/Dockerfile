#############################################################################################################################
# Dockerfile to build a container for bioservices, a python package that provides access to many Bioinformatics Web Services 
# Based on python 2.7
#############################################################################################################################

# Set the base image to python official 2-onbuild
FROM python:2.7

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install compiler
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils

# Install pip
RUN apt-get install --yes \
 python-pip
RUN pip install --upgrade pip
# Install bioservices
RUN pip install httplib2
RUN pip install line_profiler
RUN pip install pandas
#RUN pip install bioservices 
RUN pip install bioservices==1.4.15 
WORKDIR  /
RUN mkdir .config
RUN mkdir .cache
WORKDIR /.config
RUN mkdir bioservices
WORKDIR /.cache
RUN mkdir bioservices
WORKDIR /
RUN chmod 777 -R /.config/bioservices 
RUN chmod 777 -R /.cache/bioservices 

