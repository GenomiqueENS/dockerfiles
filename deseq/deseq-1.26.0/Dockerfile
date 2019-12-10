############################################################
# Dockerfile to build DESeq container images
# Based on Ubuntu
############################################################

# Set the base image to Bioconductor v3.10 and R v3.6.1
FROM bioconductor/release_base2:R.3.6.1_Bioc3.10

# File Author / Maintainer
MAINTAINER Charlotte Berthelier

# Default command to execute at startup of the container
CMD R --no-save

# Install DESeq2 package 
RUN R -e 'BiocManager::install("DESeq2")'


