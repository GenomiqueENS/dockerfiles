####################################################
#    Dockerfile to build SC Clustering	   	   #
#  		container images   		   #
#            Based on seurat 1.4.0.16              #
####################################################
# Set the base image to seurat 1.4.0.16
FROM genomicpariscentre/seurat:1.4.0.16

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN mkdir /scripts; \
    cd /scripts; \
    apt-get install --yes wget; \
    wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/seurat.R; \
    apt-get clean; \
    apt-get remove --purge --yes wget; \
    cd / ;




