###################################################
# Dockerfile to build scdd 1.0.0 container images #
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
     r-base=3.4.1-1trusty0 \
     r-base-core=3.4.1-1trusty0 \
     r-base-dev=3.4.1-1trusty0 \
     r-recommended=3.4.1-1trusty0 \
     r-base-html=3.4.1-1trusty0 \
     r-cran-boot=1.3-17-1trusty0 \
     r-cran-matrix=1.2-10-1trusty0 \
     r-cran-mgcv=1.8-13-1trusty0 \
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
     wget http://cran.rstudio.com/src/contrib/Archive/maps/maps_3.1.1.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/spam/spam_1.3-0.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/fields/fields_8.4-1.tar.gz \
          http://cran.rstudio.com/src/contrib/dotCall64_0.9-04.tar.gz; \
     R CMD INSTALL dotCall64_0.9-04.tar.gz spam_1.3-0.tar.gz maps_3.1.1.tar.gz fields_8.4-1.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/mclust/mclust_5.2.3.tar.gz; \
     R CMD INSTALL mclust_5.2.3.tar.gz; \
     R -e "install.packages('outliers', repos='http://cran.r-project.org' )"; \
     wget http://cran.rstudio.com/src/contrib/Archive/arm/arm_1.9-1.tar.gz; \
     R CMD INSTALL arm_1.9-1.tar.gz; \
     echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile; \
     R -e 'install.packages(c("futile.logger", "dynamicTreeCut", "dplyr", "shinydashboard", "rjson"))'; \
     wget http://cran.r-project.org/src/contrib/Archive/snow/snow_0.4-1.tar.gz \
     http://www.bioconductor.org/packages/3.3/bioc/src/contrib/BiocParallel_1.6.6.tar.gz;\
     R CMD INSTALL snow_0.4-1.tar.gz BiocParallel_1.6.6.tar.gz;\
     wget http://www.bioconductor.org/packages/3.4/bioc/src/contrib/BiocGenerics_0.20.0.tar.gz \
     http://www.bioconductor.org/packages/3.3/bioc/src/contrib/Biobase_2.32.0.tar.gz \
     http://cran.rstudio.com/src/contrib/Archive/matrixStats/matrixStats_0.50.2.tar.gz; \
     R CMD INSTALL matrixStats_0.50.2.tar.gz BiocGenerics_0.20.0.tar.gz Biobase_2.32.0.tar.gz;\
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/limma_3.28.21.tar.gz; \
     R CMD INSTALL limma_3.28.21.tar.gz; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/edgeR_3.14.0.tar.gz; \
     R CMD INSTALL edgeR_3.14.0.tar.gz; \
     wget https://cran.r-project.org/src/contrib/Archive/zoo/zoo_1.7-13.tar.gz; \
     R CMD INSTALL zoo_1.7-13.tar.gz; \
     R -e 'install.packages("viridis")'; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/tximport_1.0.3.tar.gz; \
     R CMD INSTALL tximport_1.0.3.tar.gz; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/biomaRt_2.28.0.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/AnnotationDbi_1.34.4.tar.gz \
          http://www.bioconductor.org/packages/3.4/bioc/src/contrib/IRanges_2.8.2.tar.gz \
          http://www.bioconductor.org/packages/3.4/bioc/src/contrib/S4Vectors_0.12.2.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/RSQLite/RSQLite_1.0.0.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/DBI/DBI_0.4-1.tar.gz; \
     R CMD INSTALL DBI_0.4-1.tar.gz RSQLite_1.0.0.tar.gz S4Vectors_0.12.2.tar.gz IRanges_2.8.2.tar.gz AnnotationDbi_1.34.4.tar.gz biomaRt_2.28.0.tar.gz;  \
     wget http://cran.rstudio.com/src/contrib/Archive/data.table/data.table_1.9.6.tar.gz \
     http://cran.r-project.org/src/contrib/Archive/chron/chron_2.3-47.tar.gz ; \
     R CMD INSTALL chron_2.3-47.tar.gz data.table_1.9.6.tar.gz; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/rhdf5_2.16.0.tar.gz \
     http://www.bioconductor.org/packages/3.3/bioc/src/contrib/zlibbioc_1.18.0.tar.gz; \
     R CMD INSTALL zlibbioc_1.18.0.tar.gz rhdf5_2.16.0.tar.gz; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/scater_1.0.4.tar.gz \
     http://www.bioconductor.org/packages/3.3/bioc/src/contrib/scran_1.0.4.tar.gz; \
     R CMD INSTALL scater_1.0.4.tar.gz scran_1.0.4.tar.gz; \
     R -e "install.packages(c('bitops', 'RCurl'))";\
     wget http://cran.rstudio.com/src/contrib/Archive/lattice/lattice_0.20-33.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/Matrix/Matrix_1.2-6.tar.gz \
          http://www.bioconductor.org/packages/3.4/bioc/src/contrib/GenomeInfoDb_1.10.3.tar.gz \
          http://www.bioconductor.org/packages/3.4/bioc/src/contrib/XVector_0.14.1.tar.gz \
          http://www.bioconductor.org/packages/3.4/bioc/src/contrib/GenomicRanges_1.26.4.tar.gz \
          https://www.bioconductor.org/packages/3.4/bioc/src/contrib/SummarizedExperiment_1.4.0.tar.gz; \
     R CMD INSTALL lattice_0.20-33.tar.gz  Matrix_1.2-6.tar.gz GenomeInfoDb_1.10.3.tar.gz XVector_0.14.1.tar.gz GenomicRanges_1.26.4.tar.gz SummarizedExperiment_1.4.0.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/nlme/nlme_3.1-128.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/RcppEigen/RcppEigen_0.3.2.0.2.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/coda/coda_0.18-1.tar.gz; \
     R CMD INSTALL nlme_3.1-128.tar.gz RcppEigen_0.3.2.0.2.tar.gz coda_0.18-1.tar.gz; \
     R -e "install.packages(c('minqa','nloptr', 'lme4', 'abind', 'arm'))"; \
     R -e "install.packages(c('blockmodeling', 'praise', 'magrittr', 'gtools'))"; \
     wget http://cran.rstudio.com/src/contrib/Archive/digest/digest_0.6.11.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/crayon/crayon_1.3.1.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/R6/R6_2.1.2.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/gdata/gdata_2.17.0.tar.gz; \
     R CMD INSTALL digest_0.6.11.tar.gz crayon_1.3.1.tar.gz R6_2.1.2.tar.gz gdata_2.17.0.tar.gz; \
     R -e "install.packages(c('testthat', 'caTools', 'KernSmooth', 'gplots'))"; \
     wget http://www.bioconductor.org/packages/3.4/bioc/src/contrib/EBSeq_1.14.0.tar.gz \
          http://www.bioconductor.org/packages/release/bioc/src/contrib/scDD_1.0.0.tar.gz; \
     R CMD INSTALL EBSeq_1.14.0.tar.gz scDD_1.0.0.tar.gz; \
     rm *.tar.gz; \
     apt-get remove --purge --yes wget; \
     apt-get clean;
