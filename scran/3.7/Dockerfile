####################################################
# Dockerfile to build Scran 1.8.2 container images #
#                 Based on SCE 3.7                 #
####################################################
# Set the base image to Ubuntu
FROM genomicpariscentre/ggplot2:3.0.0

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN R -e "biocLite('scran'); install.packages('limSolve')";
 