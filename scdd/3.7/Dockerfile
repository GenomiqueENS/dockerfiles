###################################################
# Dockerfile to build scdd 1.4.0 container images #
#                Based on SCE 3.7                 #
###################################################

# Set the base image to Ubuntu
FROM genomicpariscentre/singlecellexperiment:3.7

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs
RUN R -e "biocLite('scDD')";
