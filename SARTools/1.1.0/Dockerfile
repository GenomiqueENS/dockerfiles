############################################################
# Dockerfile to build SARTools 1.1.0 container images
# with packages DESeq2 1.8.1, edgeR 3.10.2, 
# genefilter 1.50.0 and devtools 1.8.0
# 
# Based on Ubuntu 14.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Alexandra Bomane <bomane@biologie.ens.fr>

# Update /etc/apt/sources.list
RUN echo "deb http://cran.rstudio.com/bin/linux/debian wheezy-cran3/" >> /etc/apt/sources.list

# Add the key
RUN apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480

# Update sources
RUN apt-get update

# Install R and wget
RUN apt-get install --yes -f r-base=3.2.1-4~wheezycran3.0 wget libcurl4-openssl-dev libssl-dev libxml2-dev curl

# Set CRAN repository to use
RUN echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile

# Install bioconductor
# Force Bioconductor 2.10 version
RUN wget http://bioconductor.org/biocLite.R

RUN R -e 'source("biocLite.R"); biocLite(c("DESeq2", "edgeR", "genefilter")); install.packages("devtools"); library(devtools); install_github("PF2-pasteur-fr/SARTools", build_vignettes=TRUE)'
RUN rm biocLite.R

# Cleanup
RUN apt-get remove --purge --yes wget
RUN apt-get clean

# Default command to execute at startup of the container
CMD R --no-save
