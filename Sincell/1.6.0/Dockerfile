######################################################
# Dockerfile to build Sincell 1.6.0 container images #
#             Based on Ubuntu  14.04                 #
######################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

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
     wget; \
     echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile; \
     wget http://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_0.12.10.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/scatterplot3d/scatterplot3d_0.3-37.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/MASS/MASS_7.3-45.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/cluster/cluster_2.0.4.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/statmod/statmod_1.4.24.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/proxy/proxy_0.4-16.tar.gz; \
     R CMD INSTALL Rcpp_0.12.10.tar.gz scatterplot3d_0.3-37.tar.gz MASS_7.3-45.tar.gz cluster_2.0.4.tar.gz statmod_1.4.24.tar.gz proxy_0.4-16.tar.gz; \
     R -e 'install.packages(c("entropy", "iterators", "Rtsne", "fastICA"))'; \
     wget http://cran.r-project.org/src/contrib/Archive/codetools/codetools_0.2-14.tar.gz; \
     R CMD INSTALL codetools_0.2-14.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/colorspace/colorspace_1.2-6.tar.gz; \
     R CMD INSTALL colorspace_1.2-6.tar.gz; \
     R -e 'install.packages(c("RColorBrewer", "foreach", "ggplot2", "magrittr", "digest", "registry", "stringi", "stringr", "xtable", "pkgmaker", "gridBase", "rngtools", "doParallel", "NMF"))'; \
     wget  http://cran.rstudio.com/src/contrib/Archive/lattice/lattice_0.20-33.tar.gz \
           http://cran.rstudio.com/src/contrib/Archive/Matrix/Matrix_1.2-6.tar.gz \
           http://cran.rstudio.com/src/contrib/Archive/irlba/irlba_2.1.2.tar.gz; \
     R CMD INSTALL lattice_0.20-33.tar.gz Matrix_1.2-6.tar.gz irlba_2.1.2.tar.gz; \
     wget https://cran.rstudio.com/src/contrib/Archive/TSP/TSP_1.1-4.tar.gz; \
     R CMD INSTALL TSP_1.1-4.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/spam/spam_1.3-0.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/maps/maps_3.1.1.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/fields/fields_8.4-1.tar.gz; \
     R CMD INSTALL spam_1.3-0.tar.gz maps_3.1.1.tar.gz fields_8.4-1.tar.gz; \
     R -e 'install.packages("igraph")'; \
     wget http://bioconductor.org/packages/3.4/bioc/src/contrib/sincell_1.6.0.tar.gz; \
     R CMD INSTALL sincell_1.6.0.tar.gz; \
     rm *.tar.gz; \
     apt-get remover --purge --yes wget; \
     apt-get clean; 
     
     
    