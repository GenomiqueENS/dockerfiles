######################################################
# Dockerfile to build ggplot2 2.2.1 container images #
#                Based on Ubuntu 14.04               #
######################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/cran.list ; \
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
          r-recommended=3.3.1-1trusty0 \
          r-cran-xml=3.98-1.1-1 \
          r-cran-rcurl=1.95-4.1-1 \
          wget; \
     wget http://cran.r-project.org/src/contrib/Archive/MASS/MASS_7.3-45.tar.gz \
     http://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_0.12.10.tar.gz; \
     R CMD INSTALL Rcpp_0.12.10.tar.gz MASS_7.3-45.tar.gz; \
     R -e "install.packages(c('lazyeval', 'rlang','digest', 'gtable', 'plyr', 'reshape2'), repos='http://cran.r-project.org' )"; \
     wget http://cran.r-project.org/src/contrib/Archive/tibble/tibble_1.3.0.tar.gz; \
     R CMD INSTALL tibble_1.3.0.tar.gz; \
     R -e "install.packages(c('RColorBrewer', 'dichromat', 'munsell', 'labeling', 'scales'), repos='http://cran.r-project.org')"; \
     R -e " install.packages('ggplot2', repos='http://cran.r-project.org')"; \
     rm *.tar.gz; \
     apt-get remove --purge --yes wget; \
     apt-get clean;