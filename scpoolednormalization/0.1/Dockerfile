####################################################
#    Dockerfile to build SC Spikeless Pooled	   #
#	  Normalization  container images	   	   #
#              Based on scran 1.0.4                #
####################################################
# Set the base image to scran
FROM genomicpariscentre/scran:1.0.4

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN R -e 'install.packages("Rtsne"); install.packages("FactoMineR")'; \
mkdir /scripts;\
cd /scripts;\
apt-get install --yes wget;\
wget https://github.com/GBrelurut/Single_cell_development/tree/master/R/SCSpikelessPooledNormalization.R;\
apt-get clean;\
apt-get remove --purge --yes wget;




