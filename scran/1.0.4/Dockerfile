####################################################
# Dockerfile to build Scran 1.0.4 container images #
#     Based on Ubuntu 14.04                        #
####################################################
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
          echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile; \
          R -e 'install.packages(c("futile.logger", "snow", "dynamicTreeCut", "dplyr", "shinydashboard", "rjson"))'; \
          wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/BiocParallel_1.6.6.tar.gz;\
          R CMD INSTALL BiocParallel_1.6.6.tar.gz;\
          wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/BiocGenerics_0.18.0.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/Biobase_2.32.0.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/matrixStats/matrixStats_0.50.2.tar.gz; \
          R CMD INSTALL matrixStats_0.50.2.tar.gz BiocGenerics_0.18.0.tar.gz Biobase_2.32.0.tar.gz;\
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
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/IRanges_2.6.1.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/S4Vectors_0.10.3.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/RSQLite/RSQLite_1.0.0.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/DBI/DBI_0.4-1.tar.gz; \
          R CMD INSTALL DBI_0.4-1.tar.gz RSQLite_1.0.0.tar.gz S4Vectors_0.10.3.tar.gz IRanges_2.6.1.tar.gz AnnotationDbi_1.34.4.tar.gz biomaRt_2.28.0.tar.gz;  \
          wget http://cran.rstudio.com/src/contrib/Archive/data.table/data.table_1.9.6.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/chron/chron_2.3-47.tar.gz ; \
          R CMD INSTALL chron_2.3-47.tar.gz data.table_1.9.6.tar.gz; \
          wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/rhdf5_2.16.0.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/zlibbioc_1.18.0.tar.gz; \
          R CMD INSTALL zlibbioc_1.18.0.tar.gz rhdf5_2.16.0.tar.gz; \
          wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/scater_1.0.4.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/scran_1.0.4.tar.gz; \
          R CMD INSTALL scater_1.0.4.tar.gz scran_1.0.4.tar.gz; \
          rm *.tar.gz; \
          apt-get remove --purge --yes wget; \
          apt-get clean;
     
