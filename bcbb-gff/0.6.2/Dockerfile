############################################################
# Dockerfile to build a container image for brad Chapman gff parsing lib
# Based on Ubuntu 14.04, python 2.7 and biopython 1.63.1
############################################################

# Set the base image to biopython 1.63.1
FROM genomicpariscentre/biopython

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

# Install pip
RUN apt-get install --yes \
 python-pip

# Install gff parsing lib
RUN pip install bcbio-gff

