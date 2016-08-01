########################################################
# Dockerfile to build Babel 0.3-0 (using R 3.3.0) image
#
# Based on Ubuntu 14.04
#######################################################

# Set the base images to Ubuntu 14.04
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Alexandra Bomane <alexandra.bomane@laposte.net>

# Add CRAN source to apt
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/cran.list

# Add CRAN apt key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Update the repository source list
RUN apt-get update

# Install R 3.3.0
RUN apt-get install --yes r-base=3.3.0-1trusty0 r-base-core=3.3.0-1trusty0 r-base-dev=3.3.0-1trusty0 r-base-html=3.3.0-1trusty0 r-doc-html=3.3.0-1trusty0 r-recommended=3.3.0-1trusty0 r-cran-boot=1.3-15-1trusty0 r-cran-class=7.3-14-1trusty0 r-cran-cluster=2.0.3-1trusty0 r-cran-codetools=0.2-10-1trusty0 r-cran-foreign=0.8.66-1trusty0 r-cran-kernsmooth=2.23-15-1trusty0 r-cran-lattice=0.20-33-1trusty0 r-cran-mass=7.3-44-1trusty0 r-cran-matrix=1.2-6-1trusty0 r-cran-mgcv=1.8-7-1trusty0 r-cran-nlme=3.1.128-1trusty0 r-cran-nnet=7.3-12-1trusty0 r-cran-rpart=4.1-10-1trusty0 r-cran-spatial=7.3-10-1trusty0 r-cran-survival=2.39-4-1trusty0

# Install wget
RUN apt-get install --yes wget

# Set CRAN repository to use
RUN echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile

# Install Bioconductor
RUN wget http://bioconductor.org/biocLite.R

# Install edgeR and FactoMineR packages
RUN R -e 'source("biocLite.R"); biocLite("edgeR"); install.packages("FactoMineR"); install.packages("RColorBrewer")'

# Remove biocLite
RUN rm biocLite.R

# Install Babel 0.3-0
RUN wget http://cran.r-project.org/src/contrib/babel_0.3-0.tar.gz

RUN R CMD INSTALL babel_0.3-0.tar.gz

# Cleanup
RUN apt-get remove --purge --yes wget

RUN apt-get clean

# Default command to execute at startup of the container
CMD R --no-save
