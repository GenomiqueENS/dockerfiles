###################################################
# Dockerfile to build scde 2.8.0 container images #
#                Based on SCE 3.7                 #
###################################################

# Set the base image to Ubuntu
FROM genomicpariscentre/singlecellexperiment:3.7

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs and clean up
RUN apt-get update && apt-get install --yes \
    libcairo2-dev\
    libxt-dev;\
    apt-get clean;\
    R -e "biocLite('scde')";
