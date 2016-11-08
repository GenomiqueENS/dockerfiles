###############################################
# Dockerfile to build poretools container image
# Based on Ubuntu 14.04
# Build with:
#   sudo docker build -t poretools .
###############################################

# Use ubuntu 14.04 base image
FROM ubuntu:14.04

# File author/maintainer info
MAINTAINER Stephen Turner <lastname at virginia dot edu>

# set non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

############# BEGIN INSTALLATION ##############

# Install dependencies
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y install git \
                       python-tables \
                       python-setuptools \
                       python-pip \
                       python-dev \
                       python-tk \
		       python-matplotlib \
		       cython \
                       libhdf5-serial-dev \
                       libfreetype6-dev \
                       r-base python-rpy2 && \
    pip install numexpr --upgrade && \
    Rscript -e 'options("repos" = c(CRAN = "http://cran.rstudio.com/")); install.packages("codetools"); install.packages("MASS"); install.packages("ggplot2")'

# Install poretools
RUN git clone https://github.com/arq5x/poretools /tmp/poretools && \
    cd /tmp/poretools && \
    git checkout v0.6.0 && \
    ln -s /usr/include/freetype2/ft2build.h /usr/include/ && \
    python setup.py install ; \
    python setup.py install ; \
    python setup.py install

############## INSTALLATION END ##############

# Set entrypoint so container can be used as executable
ENTRYPOINT ["poretools"]
