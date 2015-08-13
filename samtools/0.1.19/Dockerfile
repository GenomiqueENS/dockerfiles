######################################################
# Dockerfile to build Samtools 0.1.19 container images
# Based on Ubuntu
#####################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Alexandra Bomane <bomane@biologie.ens.fr>

# Update the repository sources list and install samtools package
RUN apt-get update && apt-get -y install samtools=0.1.19-1  && apt-get clean
