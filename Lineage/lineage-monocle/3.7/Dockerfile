####################################################
#      Dockerfile to build lineage-monocle 	   #
#	         container images	   	   #
#              Based on monocle 2.8.0              #
####################################################
# Set the base image to monocle
FROM genomicpariscentre/monocle:2.8.0

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN mkdir /scripts;\
cd /scripts;\
apt-get install --yes wget;\
wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/SCEmonocle.R;\
apt-get clean;


