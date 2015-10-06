############################################################
# Dockerfile to build a container with biopython and python facilities to work on biological object
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

# Install pip
RUN apt-get install --yes \
 python-pip

# Install gff parsing lib (brad Chapman gff parsing lib)
RUN pip install bcbio-gff
# Install pyfasta
RUN pip install pyfasta

