########################################################
# Dockerfile to build SCPattern 0.0.4 container images #
#               Based on Ubuntu  14.04                 #
########################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author
MAINTAINER Geoffray Brelurut

# Install required programs and clean up
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/cran.list; \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9; \
	apt-get update && apt-get install --yes \
	r-base=3.3.1-1trusty0 \
	r-base-core=3.3.1-1trusty0 \
	r-base-dev=3.3.1-1trusty0 \
	r-recommended=3.3.1-1trusty0 \
	r-base-html=3.3.1-1trusty0 \
	r-cran-boot=1.3-17-1trusty0 \
	r-cran-class=7.3-14-1trusty0 \
	r-cran-cluster=2.0.4-1trusty0 \
	r-cran-codetools=0.2-14-2trusty0 \
	r-cran-foreign=0.8.66-1trusty0 \
	r-cran-kernsmooth=2.23-15-2trusty0 \
	r-cran-lattice=0.20-33-1trusty0 \
	r-cran-mass=7.3-44-1trusty0 \
	r-cran-matrix=1.2-6-1trusty0 \
	r-cran-mgcv=1.8-13-1trusty0 \
	r-cran-nlme=3.1.128-2trusty0 \
	r-cran-nnet=7.3-12-1trusty0 \
	r-cran-rpart=4.1-10-1trusty0 \
	r-cran-spatial=7.3-10-1trusty0 \
	r-cran-survival=2.39-4-2trusty0 \
	r-doc-html=3.3.1-1trusty0 \
	libcurl4-gnutls-dev \
	libssl-dev \
	xserver-xorg-dev \
	libglu1-mesa-dev; \
	echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile; \
	R -e 'install.packages("devtools"); source("https://bioconductor.org/biocLite.R"); biocLite("BiocInstaller"); install.packages("VGAM"); devtools::install_github("lengning/SCPattern/package/SCPattern")'; \
	apt-get clean;
	
