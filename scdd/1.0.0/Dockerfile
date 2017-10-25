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
     wget http://cran.r-project.org/src/contrib/digest_0.6.12.tar.gz; \
     if [ ! -f ./digest_0.6.12.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/digest/digest_0.6.12.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/lazyeval_0.2.0.tar.gz; \
     if [ ! -f ./lazyeval_0.2.0.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/lazyeval/lazyeval_0.2.0.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/rlang_0.1.1.tar.gz; \
     if [ ! -f ./rlang_0.1.1.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/rlang/rlang_0.1.1.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/gtable_0.2.0.tar.gz; \
     if [ ! -f ./gtable_0.2.0.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/gtable/gtable_0.2.0.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/stringi_1.1.5.tar.gz; \
     if [ ! -f ./stringi_1.1.5.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/stringi/stringi_1.1.5.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/stringr_1.2.0.tar.gz \
          http://cran.rstudio.com/src/contrib/magrittr_1.5.tar.gz; \
     if [ ! -f ./stringr_1.2.0.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/stringr/stringr_1.2.0.tar.gz; \
     fi; \
     if [ ! -f magrittr_1.5.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/margittr/magrittr_1.5.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/plyr_1.8.4.tar.gz; \
     if [ ! -f ./plyr_1.8.4.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/plyr/plyr_1.8.4.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/reshape2_1.4.2.tar.gz; \
     if [ ! -f ./reshape2_1.4.2.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/reshape2/reshape2_1.4.2.tar.gz; \
     fi; \
     R CMD INSTALL digest_0.6.12.tar.gz lazyeval_0.2.0.tar.gz rlang_0.1.1.tar.gz gtable_0.2.0.tar.gz stringi_1.1.5.tar.gz magrittr_1.5.tar.gz stringr_1.2.0.tar.gz plyr_1.8.4.tar.gz reshape2_1.4.2.tar.gz; \
     wget http://cran.r-project.org/src/contrib/Archive/tibble/tibble_1.3.0.tar.gz; \
     R CMD INSTALL tibble_1.3.0.tar.gz; \
     wget http://cran.r-project.org/src/contrib/RColorBrewer_1.1-2.tar.gz; \
     if [ ! -f RColorBrewer_1.1-2.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/RColorBrewer/RColorBrewer_1.1-2.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/dichromat_2.0-0.tar.gz; \
     if [ ! -f dichromat_2.0-0.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/dichromat/dichromat_2.0-0.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/munsell_0.4.3.tar.gz; \
     if [ ! -f munsell_0.4.3.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/munsell/munsell_0.4.3.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/colorspace_1.2-6.tar.gz; \
     if [ ! -f color_space_1.2-6.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/colorspace/colorspace_1.2-6.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/labeling_0.3.tar.gz; \
     if [ ! -f labeling_0.3.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/labeling/labeling_0.3.tar.gz; \
     fi; \
     wget http://cran.r-project.org/src/contrib/scales_0.4.1.tar.gz; \
     if [ ! -f scales_0.4.1.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/scales/scales_0.4.1.tar.gz; \
     fi; \
     R CMD INSTALL RColorBrewer_1.1-2.tar.gz dichromat_2.0-0.tar.gz colorspace_1.2-6.tar.gz munsell_0.4.3.tar.gz labeling_0.3.tar.gz scales_0.4.1.tar.gz; \
     wget http://cran.r-project.org/src/contrib/ggplot2_2.2.1.tar.gz; \
     if [ ! -f ggplot2_2.2.1.tar.gz ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/ggplot2/ggplot2_2.2.1.tar.gz; \
     fi; \
     R CMD INSTALL ggplot2_2.2.1.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/maps/maps_3.1.1.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/spam/spam_1.3-0.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/fields/fields_8.4-1.tar.gz \
          http://cran.rstudio.com/src/contrib/dotCall64_0.9-04.tar.gz; \
     R CMD INSTALL dotCall64_0.9-04.tar.gz spam_1.3-0.tar.gz maps_3.1.1.tar.gz fields_8.4-1.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/mclust/mclust_5.2.3.tar.gz; \
     R CMD INSTALL mclust_5.2.3.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/outliers_0.14.tar.gz; \
     if [ ! -f outliers_0.14.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/outliers/outliers_0.14.tar.gz; \
     fi; \
     R CMD INSTALL outliers_0.14.tar.gz; \
     wget http://cran.r-project.org/src/contrib/Archive/htmltools/htmltools_0.3.5.tar.gz; \
     R CMD INSTALL htmltools_0.3.5.tar.gz; \
     wget http://cran.r-project.org//src/contrib/bindr_0.1.tar.gz; \
     if [ ! -f ./bindr_0.1.tar.gz ]; \
     then wget http://cran.r-project.org//src/contrib/bindr/bindr_0.1.tar.gz; \
     fi; \
     R CMD INSTALL bindr_0.1.tar.gz; \
     wget http://cran.r-project.org//src/contrib/plogr_0.1-1.tar.gz; \
     if [ ! -f ./plogr_0.1-1.tar.gz ]; \
     then wget http://cran.r-project.org//src/contrib/plogr/plogr_0.1-1.tar.gz; \
     fi; \
     R CMD INSTALL plogr_0.1-1.tar.gz; \
     wget http://cran.r-project.org//src/contrib/glue_1.1.1.tar.gz; \
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
     then wget http://cran.r-project.org/src/contrib/Archive/dynamicTreeCut/dynamicTreeCut_1.63-1.tar.gz ; \
     fi; \
     R CMD INSTALL dynamicTreeCut_1.63-1.tar.gz ; \
      wget http://cran.r-project.org/src/contrib/rjson_0.2.15.tar.gz ; \
     if [ ! -f  rjson_0.2.15.tar.gz   ]; \
     then wget http://cran.r-project.org/src/contrib/Archive/rjson/rjson_0.2.15.tar.gz ; \
     fi; \
     R CMD INSTALL rjson_0.2.15.tar.gz ; \
     wget http://cran.r-project.org//src/contrib/httpuv_1.3.5.tar.gz; \
     if [ ! -f httpuv_1.3.5.tar.gz ]; \
     then wget http://cran.r-project.org//src/contrib/Archive/httpuv/httpuv_1.3.5.tar.gz; \
     fi; \
     R CMD INSTALL httpuv_1.3.5.tar.gz; \
     wget http://cran.r-project.org/src/contrib/Archive/mime/mime_0.3.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/jsonlite/jsonlite_0.9.19.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/xtable/xtable_1.8-0.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/sourcetools/sourcetools_0.1.5.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/shiny/shiny_1.0.0.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/shinydashboard/shinydashboard_0.5.1.tar.gz; \
     R CMD INSTALL mime_0.3.tar.gz jsonlite_0.9.19.tar.gz xtable_1.8-0.tar.gz sourcetools_0.1.5.tar.gz shiny_1.0.0.tar.gz shinydashboard_0.5.1.tar.gz; \
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
     wget http://cran.r-project.org/src/contrib/Archive/viridisLite/viridisLite_0.1.3.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/gridExtra/gridExtra_2.2.1.tar.gz \
          https://cran.r-project.org/src/contrib/Archive/viridis/viridis_0.3.4.tar.gz; \
     R CMD INSTALL viridisLite_0.1.3.tar.gz gridExtra_2.2.1.tar.gz viridis_0.3.4.tar.gz; \
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
     wget http://cran.rstudio.com/src/contrib/bitops_1.0-6.tar.gz \
          http://cran.rstudio.com/src/contrib/RCurl_1.95-4.8.tar.gz; \
     if [ ! -f bitops_1.0-6.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/bitops/bitops_1.0-6.tar.gz; \
     fi; \
     if [ ! -f RCurl_1.95-4.8.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/RCurl/RCurl_1.95-4.8.tar.gz; \
     fi; \
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
     wget http://cran.rstudio.com/src/contrib/minqa_1.2.4.tar.gz \
          http://cran.rstudio.com/src/contrib/nloptr_1.0.4.tar.gz \
          http://cran.rstudio.com/src/contrib/lme4_1.1-13.tar.gz \
          http://cran.rstudio.com/src/contrib/abind_1.4-5.tar.gz \
          http://cran.rstudio.com/src/contrib/arm_1.9-3.tar.gz; \
     if [ ! -f minqa_1.2.4.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/minqa/minqa_1.2.4.tar.gz; \
     fi; \
     if [ ! -f nloptr_1.0.4.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/nloptr/nloptr_1.0.4.tar.gz; \
     fi; \
     if [ ! -f lme4_1.1-13.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/lme4/lme4_1.1-13.tar.gz; \
     fi; \
     if [ ! -f abind_1.4-5.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/abind/abind_1.4-5.tar.gz; \
     fi; \
     if [ ! -f arm_1.9-3.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/arm/arm_1.9-3.tar.gz; \
     fi; \
     R CMD INSTALL minqa_1.2.4.tar.gz nloptr_1.0.4.tar.gz lme4_1.1-13.tar.gz abind_1.4-5.tar.gz arm_1.9-3.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/Archive/memoise/memoise_1.0.0.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/crayon/crayon_1.3.1.tar.gz; \
     R CMD INSTALL memoise_1.0.0.tar.gz crayon_1.3.1.tar.gz; \
     wget http://cran.rstudio.com/src/contrib/praise_1.0.0.tar.gz \
          http://cran.rstudio.com/src/contrib/blockmodeling_0.1.9.tar.gz \
          http://cran.rstudio.com/src/contrib/testthat_1.0.2.tar.gz \
          http://cran.rstudio.com/src/contrib/gtools_3.5.0.tar.gz \
          http://cran.rstudio.com/src/contrib/Archive/gdata/gdata_2.17.0.tar.gz \
          http://cran.rstudio.com/src/contrib/caTools_1.17.1.tar.gz \
          http://cran.rstudio.com/src/contrib/KernSmooth_2.23-15.tar.gz \
          http://cran.rstudio.com/src/contrib/gplots_3.0.1.tar.gz; \
     if [ ! -f praise_1.0.0.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/praise/praise_1.0.0.tar.gz; \
     fi; \
     if [ ! -f blockmodeling_0.1.9.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/blockmodeling/blockmodeling_0.1.9.tar.gz; \
     fi; \
     if [ ! -f testthat_1.0.2.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/testthat/testthat_1.0.2.tar.gz; \
     fi; \
     if [ ! -f gtools_3.5.0.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/gtools/gtools_3.5.0.tar.gz; \
     fi; \
     if [ ! -f caTools_1.17.1.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/caTools/caTools_1.17.1.tar.gz; \
     fi; \
     if [ ! -f KernSmooth_2.23-15.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/KernSmooth/KernSmooth_2.23-15.tar.gz; \
     fi; \
     if [ ! -f gplots_3.0.1.tar.gz ]; \
     then wget http://cran.rstudio.com/src/contrib/Archive/gplots/gplots_3.0.1.tar.gz; \
     fi; \
     R CMD INSTALL praise_1.0.0.tar.gz blockmodeling_0.1.9.tar.gz testthat_1.0.2.tar.gz gtools_3.5.0.tar.gz gdata_2.17.0.tar.gz caTools_1.17.1.tar.gz KernSmooth_2.23-15.tar.gz gplots_3.0.1.tar.gz; \
     wget http://www.bioconductor.org/packages/3.4/bioc/src/contrib/EBSeq_1.14.0.tar.gz \
          http://www.bioconductor.org/packages/release/bioc/src/contrib/scDD_1.0.0.tar.gz; \
     R CMD INSTALL EBSeq_1.14.0.tar.gz scDD_1.0.0.tar.gz; \
     rm *.tar.gz; \
     apt-get remove --purge --yes wget; \
     apt-get clean;
