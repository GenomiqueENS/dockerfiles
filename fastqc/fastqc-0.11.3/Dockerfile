############################################################
# Dockerfile to build FASTQC container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install OpenJDK 7 JRE
RUN apt-get install --yes openjdk-7-jre-headless perl unzip

# Download FastQC
ADD http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip /tmp/

# Install FastQC
RUN cd /usr/local ; unzip /tmp/fastqc_*.zip
RUN chmod 755 /usr/local/FastQC/fastqc
RUN ln -s /usr/local/FastQC/fastqc /usr/local/bin/fastqc

# Cleanup
RUN rm -rf /tmp/fastqc_*.zip
