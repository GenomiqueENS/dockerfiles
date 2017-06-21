###################################################
# Dockerfile to build scde 2.0.1 container images #
#             Based on Ubuntu  14.04              #
###################################################

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
     libcairo2-dev \
     libxt-dev \
     libnlopt-dev \
     wget; \
     echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile; \
     R -e 'install.packages(c("futile.logger", "rjson", "RColorBrewer", "Cairo", "Rook", "nnet", "RMTstat", "modeltools", "nloptr"))'; \
     wget http://cran.r-project.org/src/contrib/Archive/snow/snow_0.4-1.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/BiocParallel_1.6.6.tar.gz; \
     R CMD INSTALL snow_0.4-1.tar.gz  BiocParallel_1.6.6.tar.gz;\
     wget http://cran.r-project.org/src/contrib/Archive/MASS/MASS_7.3-45.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/RcppArmadillo/RcppArmadillo_0.7.200.2.0.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_0.12.10.tar.gz; \
     R CMD INSTALL Rcpp_0.12.10.tar.gz RcppArmadillo_0.7.200.2.0.tar.gz MASS_7.3-45.tar.gz; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/BiocGenerics_0.18.0.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/Biobase_2.32.0.tar.gz \
          http://bioconductor.riken.jp/packages/3.3/bioc/src/contrib/pcaMethods_1.64.0.tar.gz; \
     R CMD INSTALL BiocGenerics_0.18.0.tar.gz Biobase_2.32.0.tar.gz pcaMethods_1.64.0.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/lattice/lattice_0.20-33.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/flexmix/flexmix_2.3-13.tar.gz; \
     R CMD INSTALL lattice_0.20-33.tar.gz  flexmix_2.3-13.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/Matrix/Matrix_1.2-6.tar.gz; \
     R CMD INSTALL Matrix_1.2-6.tar.gz; \
     R -e 'install.packages(c("MatrixModels", "SparseM", "quantreg"))'; \
     wget http://cran.rstudio.com/src/contrib/Archive/nlme/nlme_3.1-128.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/mgcv/mgcv_1.8-13.tar.gz; \
     R CMD INSTALL nlme_3.1-128.tar.gz mgcv_1.8-13.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/RcppEigen/RcppEigen_0.3.2.9.1.tar.gz; \
     R CMD INSTALL RcppEigen_0.3.2.9.1.tar.gz; \
     R -e 'install.packages(c("nloptr", "minqa", "lme4", "pbkrtest", "car", "distillery", "Lmoments"))'; \
     wget http://cran.rstudio.com/src/contrib/Archive/extRemes/extRemes_2.0-7.tar.gz; \
     R CMD INSTALL extRemes_2.0-7.tar.gz; \
     wget http://bioconductor.riken.jp/packages/3.3/bioc/src/contrib/limma_3.28.21.tar.gz \
          http://bioconductor.riken.jp/packages/3.3/bioc/src/contrib/edgeR_3.14.0.tar.gz \
          http://bioconductor.riken.jp/packages/3.3/bioc/src/contrib/scde_2.0.1.tar.gz; \      
     R CMD INSTALL limma_3.28.21.tar.gz edgeR_3.14.0.tar.gz scde_2.0.1.tar.gz; \
     rm *.tar.gz; \
     apt-get remove --purge --yes wget; \
     apt-get clean;