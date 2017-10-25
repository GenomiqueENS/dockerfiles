############################################################
# Dockerfile to build UMI-tools container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Nathalie Lehmann <lehmann@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update 

# Install compiler
RUN apt-get install --yes \
 curl \
 build-essential \
 gcc-multilib \
 apt-utils

# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

# Install python
RUN apt-get install --yes \
 python2.7-dev 

# Install UMI-tools
WORKDIR /usr/local
RUN conda config --add channels r
RUN conda config --add channels defaults
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda install -c https://conda.anaconda.org/toms umi_tools

ENV PATH /usr/local/UMI-tools/umi_tools:$PATH
