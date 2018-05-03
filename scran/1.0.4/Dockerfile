####################################################
# Dockerfile to build Scran 1.0.4 container images #
#             Based on ggplot 2.2.1                #
####################################################
# Set the base image to Ubuntu
FROM genomicpariscentre/ggplot2:2.2.1

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN apt-get install --yes wget; \
     echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile; \
     wget http://cran.r-project.org/src/contrib/Archive/htmltools/htmltools_0.3.5.tar.gz; \
     R CMD INSTALL htmltools_0.3.5.tar.gz; \
     wget http://cran.r-project.org/src/contrib/bindr_0.1.tar.gz; \
     if [ ! -f ./bindr_0.1.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/bindr/bindr_0.1.tar.gz; \
     fi; \
     R CMD INSTALL bindr_0.1.tar.gz; \
     wget http://cran.r-project.org/src/contrib/plogr_0.1-1.tar.gz; \
     if [ ! -f ./plogr_0.1-1.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/plogr/plogr_0.1-1.tar.gz; \
     fi; \
     R CMD INSTALL plogr_0.1-1.tar.gz; \
     wget http://cran.r-project.org/src/contrib/glue_1.1.1.tar.gz; \
     if [ ! -f  glue_1.1.1.tar.gz ]; \
     then wget https://cran.r-project.org/src/contrib/Archive/glue/glue_1.1.1.tar.gz; \
     fi; \
     R CMD INSTALL glue_1.1.1.tar.gz; \
     wget http://cran.r-project.org/src/contrib/Archive/BH/BH_1.60.0-1.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/R6/R6_2.1.2.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/pkgconfig/pkgconfig_2.0.0.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/assertthat/assertthat_0.1.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/bindrcpp/bindrcpp_0.1.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/DBI/DBI_0.4-1.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/dplyr/dplyr_0.5.0.tar.gz; \
     R CMD INSTALL BH_1.60.0-1.tar.gz R6_2.1.2.tar.gz  pkgconfig_2.0.0.tar.gz assertthat_0.1.tar.gz bindrcpp_0.1.tar.gz DBI_0.4-1.tar.gz dplyr_0.5.0.tar.gz; \
     wget http://cran.r-project.org/src/contrib/Archive/lambda.r/lambda.r_1.1.9.tar.gz \
          http://cran.r-project.org//src/contrib/futile.options_1.0.0.tar.gz  \
          http://cran.r-project.org//src/contrib/futile.logger_1.4.3.tar.gz; \
     if [ ! -f futile.options_1.0.0.tar.gz ]; \
     then wget http://cran.r-project.org//src/contrib/Archive/futile.options/futile.options_1.0.0.tar.gz; \
     fi; \
     if [ ! -f futile.logger_1.4.3.tar.gz ]; \
     then wget http://cran.r-project.org//src/contrib/Archive/futile.logger/futile.logger_1.4.3.tar.gz; \
     fi; \
     R CMD INSTALL lambda.r_1.1.9.tar.gz futile.options_1.0.0.tar.gz futile.logger_1.4.3.tar.gz; \
     wget http://cran.r-project.org/src/contrib/dynamicTreeCut_1.63-1.tar.gz ; \
     if [ ! -f dynamicTreeCut_1.63-1.tar.gz  ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/dynamicTreeCut /dynamicTreeCut_1.63-1.tar.gz ; \
     fi; \
     R CMD INSTALL dynamicTreeCut_1.63-1.tar.gz ; \
     wget http://cran.r-project.org/src/contrib/rjson_0.2.15.tar.gz ; \
     if [ ! -f  rjson_0.2.15.tar.gz   ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/rjson/rjson_0.2.15.tar.gz ; \
     fi; \
     R CMD INSTALL rjson_0.2.15.tar.gz ; \
     wget http://cran.r-project.org/src/contrib/httpuv_1.3.5.tar.gz; \
     if [ ! -f httpuv_1.3.5.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/httpuv/httpuv_1.3.5.tar.gz; \
     fi; \
     R CMD INSTALL httpuv_1.3.5.tar.gz; \
     wget http://cran.r-project.org/src/contrib/Archive/mime/mime_0.3.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/jsonlite/jsonlite_0.9.19.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/xtable/xtable_1.8-0.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/sourcetools/sourcetools_0.1.5.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/shiny/shiny_1.0.0.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/shinydashboard/shinydashboard_0.5.1.tar.gz; \
     R CMD INSTALL mime_0.3.tar.gz jsonlite_0.9.19.tar.gz xtable_1.8-0.tar.gz sourcetools_0.1.5.tar.gz shiny_1.0.0.tar.gz shinydashboard_0.5.1.tar.gz; \
     wget http://cran.r-project.org/src/contrib/Archive/viridisLite/viridisLite_0.1.3.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/gridExtra/gridExtra_2.2.1.tar.gz \
          https://cran.r-project.org/src/contrib/Archive/viridis/viridis_0.3.4.tar.gz; \
     R CMD INSTALL viridisLite_0.1.3.tar.gz gridExtra_2.2.1.tar.gz viridis_0.3.4.tar.gz; \
     wget http://cran.r-project.org/src/contrib/quadprog_1.5-5.tar.gz \
          http://cran.r-project.org/src/contrib/lpSolve_5.6.13.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/limSolve/limSolve_1.5.5.2.tar.gz; \
     if [ ! -f lpSolve_5.6.13.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/lpSolve/lpSolve_5.6.13.tar.gz; \
     fi; \
     if [ ! -f quadprog_1.5-5.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/quadprog/quadprog_1.5-5.tar.gz; \
     fi; \
     R CMD INSTALL lpSolve_5.6.13.tar.gz quadprog_1.5-5.tar.gz limSolve_1.5.5.2.tar.gz;\
     wget http://cran.r-project.org/src/contrib/Archive/snow/snow_0.4-1.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/BiocParallel_1.6.6.tar.gz;\
     R CMD INSTALL snow_0.4-1.tar.gz BiocParallel_1.6.6.tar.gz;\
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/BiocGenerics_0.18.0.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/Biobase_2.32.0.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/matrixStats/matrixStats_0.50.2.tar.gz; \
     R CMD INSTALL matrixStats_0.50.2.tar.gz BiocGenerics_0.18.0.tar.gz Biobase_2.32.0.tar.gz;\
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/limma_3.28.21.tar.gz; \
     R CMD INSTALL limma_3.28.21.tar.gz; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/edgeR_3.14.0.tar.gz; \
     R CMD INSTALL edgeR_3.14.0.tar.gz; \
     wget https://cran.r-project.org/src/contrib/Archive/zoo/zoo_1.7-13.tar.gz; \
     R CMD INSTALL zoo_1.7-13.tar.gz; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/tximport_1.0.3.tar.gz; \
     R CMD INSTALL tximport_1.0.3.tar.gz; \
     wget http://www.bioconductor.org/packages/3.3/bioc/src/contrib/biomaRt_2.28.0.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/AnnotationDbi_1.34.4.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/IRanges_2.6.1.tar.gz \
          http://www.bioconductor.org/packages/3.3/bioc/src/contrib/S4Vectors_0.10.3.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/RSQLite/RSQLite_1.0.0.tar.gz; \
     R CMD INSTALL RSQLite_1.0.0.tar.gz S4Vectors_0.10.3.tar.gz IRanges_2.6.1.tar.gz AnnotationDbi_1.34.4.tar.gz biomaRt_2.28.0.tar.gz;  \
     wget http://cran.r-project.org/src/contrib/Archive/data.table/data.table_1.9.6.tar.gz \
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
 