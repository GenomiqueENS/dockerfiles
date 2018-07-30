##############################################
#      Dockerfile to build dge-scde 	     #
#             container images	   	     #
#            Based on scde 2.8.0             #
##############################################
# Set the base image to scde 
FROM genomicpariscentre/scde:2.8.0

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN mkdir /scripts;\
cd /scripts;\
apt-get install --yes wget;\
wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/SCEscdeErrors.R;\
wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/SCEscdePriors.R;\
wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/SCEscdeTest.R;\
apt-get clean;




