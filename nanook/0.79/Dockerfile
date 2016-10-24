############################################################
# Dockerfile to build nanook container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Install OpenJDK 8 JRE and other packages
RUN apt-get update && apt-get install --yes \
 gcc-multilib \ 
 zlib1g-dev \
 openjdk-8-jre \
 r-cran-ggplot2 \
 r-cran-scales \
 r-cran-reshape \
 r-cran-gridextra \
 libhdf5-openmpi-dev \
 mpi-default-dev \
 libhdf5-10 \
 hdf5-tools \
 libhdf5-dev \
 libhdf5-mpi-dev \
 libhdf5-mpich-10 \
 texlive-latex-base \
 texlive-latex-recommended \
 texlive-fonts-recommended \
 git \
 mercurial \
 samtools \
 libbam-dev \
 sed \
 tar

# Download SZIP
ADD https://support.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar /tmp/
# Install SZIP
WORKDIR /tmp
RUN tar -xvf szip-2.1.tar 
WORKDIR /tmp/szip-2.1
RUN ./configure --prefix=/usr/local
RUN make 
RUN make check 
RUN make install

WORKDIR /usr/local 
# Download and install last
RUN hg clone http://last.cbrc.jp/last/
WORKDIR /usr/local/last
RUN make 
RUN make install

# Download and install bwa 
WORKDIR /usr/local
RUN git clone https://github.com/lh3/bwa.git
WORKDIR /usr/local/bwa
RUN git checkout v0.7.15
RUN make 
RUN cp bwa /usr/local/bin

#Download and install nanook
WORKDIR /usr/local
RUN git clone https://github.com/TGAC/NanoOK.git
#RUN git checkout v0.79
ENV NANOOK_JAVA_ARGS -Xmx4096m
WORKDIR /usr/local/NanoOK/bin
RUN sed -i '/\#\!\/bin\/sh/a if [ -z \"$NANOOK_JAVA_ARGS\" ] ; then' nanook
RUN sed -i '/JAVA_ARGS=\"-Xmx2048m\"/a else \n   JAVA_ARGS=$NANOOK_JAVA_ARGS\n fi' nanook
ENV NANOOK_DIR /usr/local/NanoOK
ENV PATH /usr/local/NanoOK/bin:$PATH
# Cleanup
RUN rm -rf /tmp/*.tar
RUN apt-get clean
