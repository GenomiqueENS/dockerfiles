###########################################################
# Dockerfile to build a proovread container 
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
 gcc-multilib \ 
 apt-utils \ 
 zlib1g-dev \
 ncbi-blast+ \
 git \
 libncurses5-dev \
 perl \
 libbz2-dev \
 liblzma-dev 


# getting the samtools 1.2 
WORKDIR /usr/local
RUN git clone https://github.com/samtools/htslib.git
WORKDIR /usr/local/htslib
RUN make && make install
WORKDIR /usr/local
RUN git clone https://github.com/samtools/samtools.git 
WORKDIR /usr/local/samtools
RUN make && make install


WORKDIR /usr/local
RUN perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit' && cpan Log::Log4perl && cpan File::Which && cpan Time::HiRes
RUN git clone --recursive https://github.com/BioInf-Wuerzburg/proovread.git 
WORKDIR /usr/local/proovread
RUN git checkout develop 
WORKDIR /usr/local/proovread/util/bwa
RUN make

