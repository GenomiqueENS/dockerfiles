####################################################
#    Dockerfile to build SC Quality Checking	   #
#	  		container images	   		   #
#              Based on scran 1.0.4                #
####################################################
# Set the base image to ggplot2
FROM genomicpariscentre/ggplot2:2.1.0

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
mkdir /scripts;\
cd /scripts;\
apt-get install --yes wget;\
wget https://github.com/GBrelurut/Single_cell_development/tree/master/R/SCQualityChecking.R;\
apt-get clean;\
apt-get remove --purge --yes wget;




