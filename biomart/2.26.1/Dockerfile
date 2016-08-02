############################################################
# Dockerfile to build biomaRt container images
# Based on r-base 3.2.3
############################################################

# Set the base image to Ubuntu
FROM r-base:3.2.3

# File Author / Maintainer
MAINTAINER Sophie Lemoine

# Update the repository sources list
RUN apt-get update
RUN apt-get install -y \
 apt-utils

# Add CRAN source to apt
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/cran.list

# install CRAN dependancies

RUN apt-get install -y \
 r-cran-bitops \
 r-cran-xml \
 r-cran-dbi \
 r-cran-rcurl \
 r-cran-rsqlite
 

# Install bioconductor
RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("biomaRt")'

# Default command to execute at startup of the container
CMD R --no-save

# Cleanup
RUN apt-get clean
