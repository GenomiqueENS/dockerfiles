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
			  libhts0 \
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
RUN pip install pyBigWig


RUN git clone --branch 1.3 https://github.com/samtools/htslib.git
WORKDIR /htslib
RUN make
RUN make install

ENV HTSLIB_LIBRARY_DIR=/usr/local/lib
ENV HTSLIB_INCLUDE_DIR=/usr/local/include
ENV USER="root"

WORKDIR / 

RUN pip install pysam

# Install Deeptools
WORKDIR /usr/local/
RUN git clone https://github.com/fidelram/deepTools.git
WORKDIR /usr/local/deepTools
RUN git checkout 2.5.4
RUN python setup.py install 

RUN apt-get clean
