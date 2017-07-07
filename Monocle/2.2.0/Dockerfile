######################################################
# Dockerfile to build Monocle 2.2.0 container images #
#               Based on Ubuntu                      #
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
         wget; \
    echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile; \
    wget http://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_0.12.10.tar.gz \
         http://cran.rstudio.com/src/contrib/Archive/MASS/MASS_7.3-45.tar.gz \
         http://cran.rstudio.com/src/contrib/Archive/cluster/cluster_2.0.4.tar.gz \
         http://cran.rstudio.com/src/contrib/Archive/proxy/proxy_0.4-16.tar.gz \
         http://cran.rstudio.com/src/contrib/colorspace/colorspace_1.2-6.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/codetools/codetools_0.2-14.tar.gz; \
    R CMD INSTALL Rcpp_0.12.10.tar.gz scatterplot3d_0.3-37.tar.gz MASS_7.3-45.tar.gz cluster_2.0.4.tar.gz proxy_0.4-16.tar.gz colorspace_1.2-6.tar.gz codetools_0.2-14.tar.gz; \
    R -e "install.packages(c('lazyeval', 'rlang','digest', 'gtable', 'plyr', 'magrittr', 'sringi', 'stringr', 'reshape2'), repos='http://cran.r-project.org' )"; \
    wget http://cran.r-project.org/src/contrib/Archive/tibble/tibble_1.3.0.tar.gz; \
    R CMD INSTALL tibble_1.3.0.tar.gz; \
    R -e "install.packages(c('RColorBrewer', 'dichromat', 'munsell', 'labeling', 'scales'), repos='http://cran.r-project.org')"; \
    R -e "install.packages(c('ggplot2', 'pheatmap'), repos='http://cran.r-project.org')"; \
    R -e 'install.packages(c("iterators", "foreach", "registry", "xtable", "pkgmaker", "gridBase", "rngtools", "doParallel", "NMF"))'; \
    wget http://cran.rstudio.com/src/contrib/Archive/lattice/lattice_0.20-33.tar.gz \
         http://cran.rstudio.com/src/contrib/Archive/Matrix/Matrix_1.2-6.tar.gz \
         http://cran.rstudio.com/src/contrib/Archive/irlba/irlba_2.1.2.tar.gz; \
    R CMD INSTALL lattice_0.20-33.tar.gz Matrix_1.2-6.tar.gz irlba_2.1.2.tar.gz; \
    R -e 'install.packages("igraph")'; \
    R -e "install.packages(c('fastICA', 'VGAM'), repos='http://cran.r-project.org' )"; \
    wget http://cran.rstudio.com/src/contrib/Archive/RcppEigen/RcppEigen_0.3.2.9.1.tar.gz \
         http://cran.rstudio.com/src/contrib/Archive/BH/BH_1.60.0-2.tar.gz \
         http://cran.rstudio.com/src/contrib/Archive/DDRTree/DDRTree_0.1.4.tar.gz; \
    R CMD INSTALL RcppEigen_0.3.2.9.1.tar.gz BH_1.60.0-2.tar.gz DDRTree_0.1.4.tar.gz; \
    R -e "install.packages('combinat')"; \
    wget http://cran.rstudio.com/src/contrib/Archive/matrixStats/matrixStats_0.50.2.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz; \
    R CMD INSTALL matrixStats_0.50.2.tar.gz slam_0.1-37.tar.gz; \
    R -e "install.packages (c('qlcMatrix', 'glue', 'bindr', 'plogr'))"; \
    wget http://cran.r-project.org/src/contrib/Archive/R6/R6_2.1.2.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/pkgconfig/pkgconfig_2.0.0.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/assertthat/assertthat_0.1.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/bindrcpp/bindrcpp_0.1.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/DBI/DBI_0.4-1.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/dplyr/dplyr_0.5.0.tar.gz; \
    R CMD INSTALL R6_2.1.2.tar.gz  pkgconfig_2.0.0.tar.gz assertthat_0.1.tar.gz bindrcpp_0.1.tar.gz DBI_0.4-1.tar.gz dplyr_0.5.0.tar.gz; \
    wget http://www.bioconductor.org/packages/3.4/bioc/src/contrib/BiocGenerics_0.20.0.tar.gz \
         http://www.bioconductor.org/packages/3.4/bioc/src/contrib/Biobase_2.34.0.tar.gz \
         http://www.bioconductor.org/packages/3.4/bioc/src/contrib/limma_3.30.13.tar.gz \
         http://www.bioconductor.org/packages/3.4/data/experiment/src/contrib/HSMMSingleCell_0.108.0.tar.gz \
         http://www.bioconductor.org/packages/3.4/bioc/src/contrib/monocle_2.2.0.tar.gz; \
    R CMD INSTALL BiocGenerics_0.20.0.tar.gz Biobase_2.34.0.tar.gz limma_3.30.13.tar.gz HSMMSingleCell_0.108.0.tar.gz monocle_2.2.0.tar.gz; \
    rm *.tar.gz; \
    apt-get remove --purge --yes wget; \
    apt-get clean;           