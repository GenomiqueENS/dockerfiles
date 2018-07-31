####################################################
# Dockerfile to build Seurat 2.3 container images  #
#              Based on Scran 1.8.2                #
####################################################
# Set the base image to Ubuntu
FROM genomicpariscentre/scran:1.8.2

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN apt-get update && apt-get install --yes\
       r-base-dev \
       libssl-dev \
       libcurl4-openssl-dev \
       libxml2-dev \
       libpng-dev; \
    R -e "install.packages(c('class', 'Seurat'))"; \
    apt-get clean;
