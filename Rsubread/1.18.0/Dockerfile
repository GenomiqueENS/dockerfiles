############################################################
# Dockerfile to build Rsubread container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Sophie Lemoine

# Add CRAN source to apt
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/cran.list

# Add CRAN apt key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Update the repository sources list
RUN apt-get update

# Install Latex
RUN apt-get install --yes texlive-latex-base texlive-latex-extra 

# Install libxml2 
RUN apt-get install --yes libxml2-dev




# Install R
RUN apt-get install --yes \
 r-base \
 r-base-core \
 r-base-dev \
 r-base-html \
 r-doc-html \
 r-recommended \
 r-cran-boot \
 r-cran-class \
 r-cran-cluster \
 r-cran-codetools \
 r-cran-foreign \
 r-cran-kernsmooth \
 r-cran-lattice \
 r-cran-mass \
 r-cran-matrix \
 r-cran-mgcv \
 r-cran-nlme \
 r-cran-nnet \
 r-cran-rpart \
 r-cran-spatial \
 r-cran-survival
# r-base=3.0.2-1ubuntu1 \
# r-base-core=3.0.2-1ubuntu1 \
# r-base-dev=3.0.2-1ubuntu1 \
# r-base-html=3.0.2-1ubuntu1 \
# r-doc-html=3.0.2-1ubuntu1 \
# r-recommended=3.0.2-1ubuntu1 \
# r-cran-boot=1.3-9-1 \
# r-cran-class=7.3-9-1 \
# r-cran-cluster=1.14.4-1 \
# r-cran-codetools=0.2-8-2 \
# r-cran-foreign=0.8.59-1 \
# r-cran-kernsmooth=2.23-10-2 \
# r-cran-lattice=0.6-26-1 \
# r-cran-mass=7.3-29-1 \
# r-cran-matrix=1.1-2-1 \
# r-cran-mgcv=1.7-28-1 \
# r-cran-nlme=3.1.113-1 \
# r-cran-nnet=7.3-7-1 \
# r-cran-rpart=4.1-5-1 \
# r-cran-spatial=7.3-7-1 \
# r-cran-survival=2.37-7-1 

# Set CRAN repository to use
RUN echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile

# Install bioconductor
RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("Rsubread")'

# Cleanup
RUN apt-get clean

# Default command to execute at startup of the container
CMD R --no-save

# Install vim
RUN apt-get install --yes vim
