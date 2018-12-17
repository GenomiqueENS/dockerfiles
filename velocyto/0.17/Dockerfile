#############################################
# Dockerfile to build velocyto image
# Based on Ubuntu 18.04
###############################################

# Use ubuntu 18.04 base image
FROM ubuntu:18.04

# File author/maintainer info
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
RUN apt-get update --fix-missing
RUN apt-get install -y build-essential \
 wget \
 bzip2 \
 ca-certificates \
 samtools \
 libbam-dev \
 libhts-dev \
 curl \
 git
RUN apt-get clean && \
 rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

RUN conda install numpy \
 scipy \
 cython \
 numba \
 matplotlib \
 scikit-learn \
 h5py \
 click \
 R \
 rpy2

# Install dependances using pip
RUN pip install --upgrade pip
RUN pip install pysam \
 loompy 
RUN pip install -U --no-deps velocyto

