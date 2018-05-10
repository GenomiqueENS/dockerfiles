##############################################
#      Dockerfile to build dge-scde 	     #
#             container images	   	     #
#            Based on scde 2.0.1             #
##############################################
# Set the base image to scde 
FROM genomicpariscentre/scde:2.0.1

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN mkdir /scripts;\
cd /scripts;\
apt-get install --yes wget;\
wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/scdeErrors.R;\
wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/scdePriors.R;\
wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/scdeTest.R;\
apt-get clean;\
apt-get remove --purge --yes wget;




