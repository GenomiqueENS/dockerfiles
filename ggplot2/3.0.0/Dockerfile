######################################################
# Dockerfile to build ggplot2 3.0.0 container images #
#                  Based on SCE 3.7                  #
######################################################

# Set the base image to Ubuntu
FROM genomicpariscentre/singlecellexperiment:3.7

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN R -e "install.packages(c('ggplot2', 'Rtsne', 'FactoMineR'))"
