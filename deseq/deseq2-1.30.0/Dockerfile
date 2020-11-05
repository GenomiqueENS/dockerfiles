############################################################
# Dockerfile to build DESeq container images
# Based on bioconductor
############################################################

# Set the base image to Bioconductor docker RELEASE_3_12
FROM bioconductor/bioconductor_docker:RELEASE_3_12

# File Author / Maintainer
MAINTAINER Charlotte Berthelier

# Default command to execute at startup of the container
CMD R --no-save

# Install DESeq2 and FactoMineR package  
RUN R -e 'BiocManager::install("DESeq2")' && R -e 'BiocManager::install("FactoMineR")' && R -e 'devtools::install_github("kassambara/factoextra")'
