############################################################
# Dockerfile to build deeptools container image
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM genomicpariscentre/kentutils:302.1.0

# File Author / Maintainer
MAINTAINER Laurent Jourdren

# Install dependencies
RUN apt-get update && \
    apt-get install --yes python-dateutil \
			  pkg-config \
			  libpython2.7-dev \
			  python-pip \
			  libagg-dev \
			  libqhull6 \
			  libcurl4-openssl-dev \
                          libfreetype6-dev 

RUN pip install --upgrade pip
RUN pip install numpy
RUN pip install scipy
RUN pip install pytz
RUN pip install cycler
RUN pip install tornado
RUN pip install pyparsing
RUN pip install matplotlib 
RUN pip install bx-python
RUN pip install pysam 
RUN pip install pyBigWig


# Install Deeptools
WORKDIR /usr/local/
RUN git clone https://github.com/fidelram/deepTools.git
WORKDIR /usr/local/deepTools
RUN git checkout 2.2.4
RUN python setup.py install 

RUN apt-get clean

