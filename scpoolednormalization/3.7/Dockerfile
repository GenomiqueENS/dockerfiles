####################################################
#    Dockerfile to build SC Spikeless Pooled	   #
#	  Normalization  container images   	   #
#              Based on scran 1.8.2                #
####################################################
# Set the base image to scran
FROM genomicpariscentre/scran:1.8.2

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN mkdir /scripts; \
    cd /scripts; \
    wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/SCESpikelessPooledNormalization.R; \
    apt-get clean;
