############################################################
# Dockerfile to build ribopicker 0.4.3 container
# Based on genomicpariscentre/bioperl
############################################################

# Set the base image to Ubuntu
FROM genomicpariscentre/bioperl   

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install perl dependancies
RUN apt-get install -y cpanminus

RUN cpanm \
 Data::Dumper \
 Getopt::Long \
 Pod::Usage \
 File::Path \
 Cwd \
 FindBin
  
# Install Ribopicker
RUN apt-get install -y \
 wget \
 unzip \
 zlib1g-dev \
 sed \
 vim 
 
WORKDIR /usr/local
RUN wget http://downloads.sourceforge.net/project/ribopicker/standalone/ribopicker-standalone-0.4.3.tar.gz 
RUN tar xzf ribopicker-standalone-0.4.3.tar.gz
RUN rm ribopicker-standalone-0.4.3.tar.gz
WORKDIR /usr/local ribopicker-standalone-0.4.3
RUN wget http://ribopicker.sourceforge.net/formatSilvaData.pl
RUN wget http://ribopicker.sourceforge.net/formatRdpData.pl
RUN wget http://ribopicker.sourceforge.net/formatGreengenesData.pl
RUN wget http://ribopicker.sourceforge.net/formatHmpData.pl
RUN wget http://ribopicker.sourceforge.net/formatRfamSeqs.pl
RUN wget http://ribopicker.sourceforge.net/formatNcbiHumanData.pl

WORKDIR /usr/local/bin
RUN ln -s /usr/local/ribopicker-standalone-0.4.3/ribopicker.pl .
RUN ln -s /usr/local/ribopicker-standalone-0.4.3/format*.pl .
RUN ln -s /usr/local/ribopicker-standalone-0.4.3/bwa64 .
RUN ln -s /usr/local/ribopicker-standalone-0.4.3/bwaMAC .
RUN chmod 777 /usr/local/ribopicker-standalone-0.4.3/riboPickerConfig.pm
# Cleanup
RUN apt-get clean

