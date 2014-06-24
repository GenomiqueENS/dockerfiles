############################################################
# Dockerfile to build Eoulsan container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM genomicpariscentre/deseq:latest

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install OpenJDK 7 JRE
RUN apt-get install --yes openjdk-7-jre-headless

# Download and install Eoulsan
ADD http://www.transcriptome.ens.fr/eoulsan/eoulsan-1.2.2.tar.gz /tmp/

# Install Eoulsan
RUN ls /tmp/eoulsan-*.tar.gz
RUN tar --directory /usr/local -xf /tmp/eoulsan-*.tar.gz

# Create links for eoulsan.sh to get eoulsan.sh in PATH
RUN ln -s /usr/local/eoulsan-*/eoulsan.sh /usr/local/bin/eoulsan.sh
RUN ln -s /usr/local/eoulsan-*/eoulsan.sh /usr/local/bin/eoulsan

# Patch bug in eoulsan.sh
RUN cat /usr/local/eoulsan-*/eoulsan.sh | sed 's/BASEDIR=`dirname $0`/ARG0=`readlink $0` ; BASEDIR=`dirname $ARG0`/' > /tmp/eoulsan.sh && mv /tmp/eoulsan.sh /usr/local/eoulsan-*/eoulsan.sh && chmod +x /usr/local/eoulsan-*/eoulsan.sh 

# Cleanup
RUN rm -rf /tmp/eoulsan-*.tar.gz
RUN apt-get clean

# Default command to execute at startup of the container
CMD eoulsan.sh --version
