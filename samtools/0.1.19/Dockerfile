######################################################
# Dockerfile to build Samtools 0.1.19 container images
# Based on Ubuntu
#####################################################

# Set the base image to Ubuntu
FROM gcc:4.9.2

# File Author / Maintainer
MAINTAINER Alexandra Bomane <bomane@biologie.ens.fr>

# Update the repository sources list and install wget
RUN apt-get update && apt-get -y install wget  && apt-get clean

# Working directory in /usr/local
WORKDIR /usr/local

# Download samtools archive
RUN wget --default-page=samtools-0.1.19.tar.bz2 http://downloads.sourceforge.net/project/samtools/samtools/0.1.19/samtools-0.1.19.tar.bz2

# Unzip the archive
RUN tar xjvf samtools-0.1.19.tar.bz2

# Remove the archive
RUN rm samtools-0.1.19.tar.bz2

# Go in samtools and launch make
RUN cd samtools-0.1.19 && make

# Symbolic link of samtools command
RUN ln -s /usr/local/samtools-0.1.19/samtools /usr/local/bin/samtools

# Working directory
WORKDIR /
