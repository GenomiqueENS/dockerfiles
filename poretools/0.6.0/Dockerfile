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
                       libhdf5-serial-dev \
                       libfreetype6-dev \
                       r-base \ 
		       pkg-config \
                       python-setuptools \
                       python-dev \
                       python-tables \
                       python-pip 

RUN pip install numpy
RUN pip install scipy 
RUN pip install matplotlib
RUN pip install seaborn
RUN pip install Cython --install-option="--no-cython-compile"
RUN pip install numexpr --upgrade
                       
RUN apt-get -y install python-pandas \
		       python-tk \
		       python-rpy2

RUN Rscript -e 'options("repos" = c(CRAN = "http://cran.rstudio.com/")); install.packages("codetools"); install.packages("MASS"); install.packages("ggplot2")'

# Install poretools
RUN git clone https://github.com/arq5x/poretools /tmp/poretools
WORKDIR /tmp/poretools
RUN git checkout v0.6.0
RUN ln -s /usr/include/freetype2/ft2build.h /usr/include/
RUN python setup.py install


# Cleanup
RUN rm -rf /tmp/poretools
RUN apt-get clean

############## INSTALLATION END ##############

# Set entrypoint so container can be used as executable
ENTRYPOINT ["poretools"]
