####################################################
#    Dockerfile to build Sum Normalization	   #
#	  	container images 		   #
#              Based on ggplot2 3.0.0              #
####################################################
# Set the base image to gglot2
FROM genomicpariscentre/ggplot2:3.0.0

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN mkdir /scripts; \
    cd /scripts; \
    wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/SCEsumNormalization.R; \
    apt-get clean;
