###########################################################
# Dockerfile to build a HG-CoLoR container 
# Based on Ubuntu 
# ########################################################### 
# Set the base image to Ubuntu 
FROM ubuntu:16.04 
# File Author / Maintainer 
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr> 
# Update the repository sources list 
RUN apt-get update 
# Install compiler and perl stuff 
RUN apt-get install --yes \
 build-essential \
 autoconf \
 automake \
 m4 \
 perl \
 ruby \
 wget \
 pkg-config \
 gcc-multilib \ 
 g++ \
 apt-utils \ 
 libtool \
 parallel \
 emboss \
 git 


# Get and install Quorum and PgSA
WORKDIR /usr/local/source
RUN wget https://github.com/gmarcais/yaggo/releases/download/v1.5.10/yaggo-1.5.10.gem
RUN gem install ./yaggo-1.5.10.gem

WORKDIR /usr/local
RUN git clone https://github.com/gmarcais/Jellyfish.git
WORKDIR /usr/local/Jellyfish
RUN autoreconf -fi && ./configure && make && make install && ldconfig

WORKDIR /usr/local
RUN git clone https://github.com/gmarcais/Quorum.git 
WORKDIR /usr/local/Quorum
RUN autoreconf -fi && ./configure && make && make install

WORKDIR /usr/local
RUN git clone https://github.com/kowallus/PgSA.git 
WORKDIR /usr/local/PgSA
RUN make build CONF=pgsalib

# Get and install HG-CoLoR
WORKDIR /usr/local
RUN git clone https://github.com/pierre-morisse/HG-CoLoR.git  
WORKDIR /usr/local/HG-CoLoR
RUN make PGSA_PATH=/usr/local/PgSA/

RUN apt-get clean 

