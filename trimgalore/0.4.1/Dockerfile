###########################################################
# Dockerfile to build image for Trim Galore! step in eoulsan
# Based on Ubuntu
###########################################################


# Set the base image to Ubuntu
FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /usr/local

# Update the repository sources list
RUN apt-get update && \
    apt-get -y install wget python gzip unzip && \
    wget https://github.com/ComputationalSystemsBiology/EoulsanDockerFiles/raw/master/TrimAdapt/cutadapt-1.8.1.tar.gz && \
    tar -xzf cutadapt-1.8.1.tar.gz && \
    ln -s /usr/local/cutadapt-1.8.1 /tmp/ && \
    rm cutadapt-1.8.1.tar.gz && \
    wget https://github.com/ComputationalSystemsBiology/EoulsanDockerFiles/raw/master/TrimAdapt/trim_galore_v0.4.1.zip && \
    unzip trim_galore_v0.4.1.zip -d . && \
    rm trim_galore_v0.4.1.zip && \
    ln -s /usr/local/trim_galore_zip/trim_galore /usr/local/bin/ && \
    touch /usr/local/bin/rename_trim_galore_output.sh && \
    ln -s /usr/local/bin/rename_trim_galore_output.sh /RenameOutput.sh && \
    chmod +x /usr/local/bin/rename_trim_galore_output.sh && \
    printf '#/bin/bash\nb=$(basename "$2")\ne=${b#*.}\nd=$(dirname "$2")\nmv "$d/$(basename "$b" .$e)_$1.fq" "$3"\n' >> /usr/local/bin/rename_trim_galore_output.sh

WORKDIR /
