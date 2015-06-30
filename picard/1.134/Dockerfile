############################################################
# Dockerfile to build FASTQC container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install OpenJDK 7 JRE
RUN apt-get install --yes openjdk-7-jre-headless unzip

# Download FastQC
ADD https://github.com/broadinstitute/picard/releases/download/1.134/picard-tools-1.134.zip /tmp/

# Install FastQC
RUN cd /usr/local ; unzip /tmp/picard-tools-*.zip
RUN chmod 755 /usr/local/picard-tools-* && chmod +x /usr/local/picard-tools-*/picard.jar

RUN ln -s /usr/local/picard-tools-*/picard.jar /usr/local/bin/picard.jar

# Cleanup
RUN rm -rf /tmp/picard-tools-*
