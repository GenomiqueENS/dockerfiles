###########################################################
# Dockerfile to build BamQC container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Aurélien Birer <birer@biologie.ens.fr>

# Run BamQC
RUN apt-get update && \
    apt install --yes \
          ant \
          openjdk-8-jdk-headless \
          git \
          libfindbin-libs-perl && \
    cd /tmp && \
    git clone https://github.com/s-andrews/BamQC.git && \
    cd /tmp/BamQC && \
    git checkout 480c091 && \
    ant && \
    chmod +x bin/bamqc && \
    cp -rp bin /usr/local/bamqc && \
    ln -s /usr/local/bamqc/bamqc /usr/local/bin/bamqc && \
    apt remove --yes --purge ant git openjdk-8-jdk-headless && apt install openjdk-8-jre-headless && apt autoremove --yes --purge && apt clean
