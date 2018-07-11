# Set the base image to Bioconductor 3.7 
FROM bioconductor/release_core2:R3.5.0_Bioc3.7

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Install the SingleCellExperiment package
RUN R --no-save -e 'biocLite("SingleCellExperiment")'
