############################################################
# Dockerfile to build CITE-seq-Count container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:18.04

# File Author / Maintainer
MAINTAINER Nathalie Lehmann

# Installation

ARG PACKAGE_VERSION=1.4.1

RUN apt-get update && apt-get upgrade -y && \
apt-get install build-essential -y && \
apt-get install libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev -y && \
apt-get install wget -y && \
apt-get install zlib1g-dev -y && \
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz && \
tar -xzvf Python-3.7.0.tgz && \
./Python-3.7.0/configure && \
make && \
make install && \
apt-get install --yes python3-pip && \
pip3 install pip==19.0.1 && \
pip3 install CITE-seq-Count==$PACKAGE_VERSION && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

