############################################################
# Dockerfile to build marginAlign container image
# Based on Ubuntu
############################################################

# Set the base image to python official 2-onbuild
FROM python:2.7

# File Author / Maintainer
MAINTAINER Sophie Lemoine

# Install dependencies
RUN apt-get update && \
    apt-get install --yes python-dateutil \
 		          build-essential \
			  gcc-multilib \
			  apt-utils \
			  pkg-config \
			  libpython2.7-dev \
			  python-pip \
			  unzip \
			  wget \
			  git 

RUN pip install --upgrade pip
RUN pip install numpy==1.9.2
RUN pip install PyVCF==0.6.7
RUN pip install pysam==0.8.2.1
RUN pip install wsgiref==0.1.2

# Install marginAlign

WORKDIR /usr/local/
RUN git clone https://github.com/benedictpaten/marginAlign.git
WORKDIR /usr/local/marginAlign
#RUN git checkout v0.1
RUN git pull && git submodule update --init
RUN make

RUN apt-get clean

