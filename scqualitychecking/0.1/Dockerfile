####################################################
#    Dockerfile to build SC Quality Checking	   #
#	         container images	   	   #
#              Based on ggplot2 2.2.1              #
####################################################
# Set the base image to ggplot2
FROM genomicpariscentre/ggplot2:2.2.1

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN mkdir /scripts;\
cd /scripts;\
apt-get install --yes wget;\
wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/SCQualityChecking.R;\
apt-get clean;\
apt-get remove --purge --yes wget;




