####################################################
#    Dockerfile to build SC Spikeless Pooled	   #
#	  Normalization  container images   	   #
#              Based on scran 1.0.4                #
####################################################
# Set the base image to scran
FROM genomicpariscentre/scran:1.0.4

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN apt-get update && apt-get install --yes wget libnlopt-dev pkg-config;\
    wget http://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_0.12.11.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/Rtsne/Rtsne_0.11.tar.gz; \
    R CMD INSTALL Rcpp_0.12.11.tar.gz Rtsne_0.11.tar.gz; \
    wget http://cran.r-project.org/src/contrib/leaps_3.0.tar.gz; \
    if [ ! -f ./leaps_3.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/leaps/leaps_3.0.tar.gz; \
    fi; \
    R CMD INSTALL leaps_3.0.tar.gz; \
    wget http://cran.r-project.org/src/contrib/flashClust_1.01-2.tar.gz; \
    if [ ! -f ./flashClust_1.01-2.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/flashClust/flashClust_1.01-2.tar.gz; \
    fi; \
    R CMD INSTALL flashClust_1.01-2.tar.gz; \
    wget http://cran.r-project.org/src/contrib/ellipse_0.3-8.tar.gz; \
    if [ ! -f ./ellipse_0.3-8.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/ellipse/ellipse_0.3-8.tar.gz; \
    fi; \
    R CMD INSTALL ellipse_0.3-8.tar.gz; \
    wget http://cran.r-project.org/src/contrib/nnet_7.3-12.tar.gz; \
    if [ ! -f nnet_7.3-12.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/nnet/nnet_7.3-12.tar.gz; \
    fi; \
    wget http://cran.r-project.org/src/contrib/minqa_1.2.4.tar.gz; \
    if [ ! -f minqa_1.2.4.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/minqa/minqa_1.2.4.tar.gz; \
    fi; \
    R CMD INSTALL minqa_1.2.4.tar.gz; \
    wget http://cran.r-project.org/src/contrib/Archive/lattice/lattice_0.20-34.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/nlme/nlme_3.1-127.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/Matrix/Matrix_1.2-7.1.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/mgcv/mgcv_1.8-12.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/RcppEigen/RcppEigen_0.3.2.9.0.tar.gz; \
    R CMD INSTALL lattice_0.20-34.tar.gz nlme_3.1-127.tar.gz Matrix_1.2-7.1.tar.gz mgcv_1.8-12.tar.gz RcppEigen_0.3.2.9.0.tar.gz; \
    wget http://cran.r-project.org/src/contrib/MatrixModels_0.4-1.tar.gz; \
    if [ ! -f MatrixModels_0.4-1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/MatrixModels/MatrixModels_0.4-1.tar.gz; \
    fi; \
    R CMD INSTALL MatrixModels_0.4-1.tar.gz; \
    wget https://cran.r-project.org/src/contrib/nloptr_1.0.4.tar.gz; \
    if [ ! -f nloptr_1.0.4.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/nloptr/nloptr_1.0.4.tar.gz; \
    fi; \
    R CMD INSTALL nloptr_1.0.4.tar.gz; \
    wget http://cran.r-project.org/src/contrib/SparseM_1.77.tar.gz; \
    if [ ! -f SparseM_1.77.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/SparseM/SparseM_1.77.tar.gz; \
    fi; \
    R CMD INSTALL SparseM_1.77.tar.gz; \
    wget http://cran.r-project.org/src/contrib/Archive/MASS/MASS_7.3-45.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/scatterplot3d/scatterplot3d_0.3-37.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/lattice/lattice_0.20-34.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/cluster/cluster_2.0.4.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/lme4/lme4_1.1-12.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/pbkrtest/pbkrtest_0.4-6.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/quantreg/quantreg_5.29.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/car/car_2.1-2.tar.gz; \
    R CMD INSTALL nloptr_1.0.0.tar.gz  MASS_7.3-45.tar.gz scatterplot3d_0.3-37.tar.gz lattice_0.20-34.tar.gz cluster_2.0.4.tar.gz lme4_1.1-12.tar.gz pbkrtest_0.4-6.tar.gz quantreg_5.29.tar.gz car_2.1-2.tar.gz; \
    wget http://cran.r-project.org/src/contrib/magrittr_1.5.tar.gz; \
    if [ ! -f magrittr_1.5.tar.gz ]; \
    then wget https://cran.r-project.org/src/contrib/Archive/magrittr/magrittr_1.5.tar.gz; \
    fi; \
    R CMD INSTALL magrittr_1.5.tar.gz; \
    wget http://cran.r-project.org/src/contrib/yaml_2.1.14.tar.gz; \
    if [ ! -f yaml_2.1.14.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/yaml/yaml_2.1.14.tar.gz; \
    fi; \
    R CMD INSTALL yaml_2.1.14.tar.gz; \
    wget http://cran.r-project.org/src/contrib/highr_0.6.tar.gz; \
    if [ ! -f highr_0.6.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/highr/highr_0.6.tar.gz; \
    fi; \
    R CMD INSTALL highr_0.6.tar.gz; \
    wget http://cran.r-project.org/src/contrib/Archive/stringi/stringi_1.1.1.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/stringr/stringr_1.0.0.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/evaluate/evaluate_0.10.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/digest/digest_0.6.9.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/mime/mime_0.3.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/markdown/markdown_0.7.7.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/knitr/knitr_1.15.1.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/FactoMineR/FactoMineR_1.35.tar.gz; \
    R CMD INSTALL stringi_1.1.1.tar.gz stringr_1.0.0.tar.gz evaluate_0.10.tar.gz digest_0.6.9.tar.gz mime_0.3.tar.gz markdown_0.7.7.tar.gz knitr_1.15.1.tar.gz FactoMineR_1.35.tar.gz; \
    rm *.tar.gz; \
    mkdir /scripts; \
    cd /scripts; \
    wget https://raw.githubusercontent.com/GBrelurut/Single_cell_development/master/R/SCSpikelessPooledNormalization.R; \
    apt-get clean; \
    apt-get remove --purge --yes wget;
