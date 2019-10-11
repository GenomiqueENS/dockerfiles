# Set the base image to Ubuntu 16.04 and NVIDIA GPU
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# File Author / Maintainer
MAINTAINER Charlotte Berthelier <bertheli@biologie.ens.fr>

ARG PACKAGE_VERSION=3.2.4

RUN apt-get update && apt-get install -y libcurl4-openssl-dev \
                                         libssl-dev \
                                         libhdf5-cpp-11 \
                                         libzmq5 \
                                         libboost-atomic1.58.0 \
                                         libboost-chrono1.58.0 \
                                         libboost-date-time1.58.0 \
                                         libboost-filesystem1.58.0 \
                                         libboost-program-options1.58.0 \
                                         libboost-regex1.58.0 \
                                         libboost-system1.58.0 \
                                         libboost-log1.58.0 \
                                         libboost-iostreams1.58.0 \
                                         wget

RUN cd /tmp &&\
    wget -q https://mirror.oxfordnanoportal.com/software/analysis/ont_guppy_${PACKAGE_VERSION}-1~xenial_amd64.deb &&\
    dpkg -i --ignore-depends=nvidia-384,libcuda1-384 /tmp/ont_guppy_${PACKAGE_VERSION}-1~xenial_amd64.deb

