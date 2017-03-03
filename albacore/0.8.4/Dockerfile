# Set the base image to Ubuntu 14.04
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

ENV TERM=dumb

# Installing albacore
RUN apt update && \
    apt install --yes wget \
                      python3 \
                      python3-h5py \
                      python3-numpy \
                      python3-pkg-resources \
                      libboost-program-options1.58.0 \
                      libboost-system1.58.0 \
                      libboost-python1.58.0 \
                      libboost-filesystem1.58.0 \
                      libboost-log1.58.0 \
                      libboost-thread1.58.0 && \
    wget https://mirror.oxfordnanoportal.com/software/analysis/python3-ont-albacore_0.8.4-1-xenial_all.deb && \
    dpkg -i python3-ont-albacore_*.deb && \
    apt clean && \
    rm python3-ont-albacore_*.deb
