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

# Install bwa
WORKDIR /usr/local/
RUN git clone https://github.com/lh3/bwa.git
WORKDIR /usr/local/bwa
RUN make
RUN ln -s bwa /usr/local/bin


# Install last
WORKDIR /usr/local/
RUN wget http://last.cbrc.jp/last-744.zip
RUN unzip last-744.zip
WORKDIR /usr/local/last-744
RUN make
RUN make install

# Install cPecan
WORKDIR /usr/local/
RUN git clone https://github.com/benedictpaten/cPecan.git
WORKDIR /usr/local/cPecan
RUN make

# Install jobtree
WORKDIR /usr/local/
RUN git clone https://github.com/benedictpaten/sonLib.git 
RUN git clone https://github.com/benedictpaten/jobTree.git
WORKDIR /usr/local/jobTree
ENV PYTHONPATH $PYTHONPATH:/usr/local/jobTree
ENV PYTHONPATH $PYTHONPATH:/usr/local/sonLib
RUN echo $PYTHONPATH
RUN echo $PATH
RUN make all && make test

# Install marginAlign

WORKDIR /usr/local/
RUN git clone https://github.com/benedictpaten/marginAlign.git
WORKDIR /usr/local/marginAlign
RUN git checkout v0.1
RUN make

RUN apt-get clean

