############################################################
# Dockerfile to build subread-1.5.1 container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine

# Update the repository sources list
RUN apt-get update

# Install compiler
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 zlib1g-dev

# Install Latex
RUN apt-get install --yes texlive-latex-base texlive-latex-extra 

# Install libxml2 
RUN apt-get install --yes libxml2-dev
RUN apt-get install --yes \
 wget 

# Install subread 
WORKDIR /usr/local/
RUN wget http://heanet.dl.sourceforge.net/project/subread/subread-1.5.1/subread-1.5.1-source.tar.gz
RUN tar xzf subread-1.5.1-source.tar.gz
WORKDIR /usr/local/subread-1.5.1-source/src
RUN make -f Makefile.Linux
RUN ln -s /usr/local/subread-1.5.1-source/bin/* /usr/local/bin


# Cleanup
RUN apt-get clean

# Default command to execute at startup of the container
CMD R --no-save

# Install vim
RUN apt-get install --yes vim
