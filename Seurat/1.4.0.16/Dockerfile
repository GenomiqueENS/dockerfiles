####################################################
# Dockerfile to build Seurat 1.4 container images  #
#              Based on Scran 1.0.4                #
####################################################
# Set the base image to Ubuntu
FROM genomicpariscentre/scran:1.0.4

# File Author
MAINTAINER Geoffray Brelurut <brelurut@biologie.ens.fr>

# Install required programs then clean up
RUN apt-get update && apt-get install --yes \
       libssl-dev \
       libcurl4-openssl-dev \
       libxml2-dev \
       openjdk-7-jre \
       wget; \
    wget http://cran.r-project.org/src/contrib/Archive/openssl/openssl_0.9.4.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/curl/curl_1.1.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/httr/httr_1.2.1.tar.gz; \
    R CMD INSTALL openssl_0.9.4.tar.gz curl_1.1.tar.gz httr_1.2.1.tar.gz; \
    wget http://cran.r-project.org/src/contrib/devtools_1.13.4.tar.gz \
         http://cran.r-project.org/src/contrib/whisker_0.3-2.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/rstudioapi/rstudioapi_0.6.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/git2r/git2r_0.15.0.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/withr/withr_2.1.0.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/memoise/memoise_1.0.0.tar.gz; \
    if [ ! -f whisker_0.3-2.tar.gz ]; \
    then wget  http://cran.r-project.org/src/contrib/Archive/whisker/whisker_0.3-2.tar.gz; \
    fi; \
    if [ ! -f devtools_1.13.4.tar.gz ]; \
    then wget  http://cran.r-project.org/src/contrib/Archive/devtools/devtools_1.13.4.tar.gz; \
    fi; \
    R CMD INSTALL memoise_1.0.0.tar.gz whisker_0.3-2.tar.gz rstudioapi_0.6.tar.gz git2r_0.15.0.tar.gz \
                  withr_2.1.0.tar.gz devtools_1.13.4.tar.gz; \
    wget http://cran.r-project.org/src/contrib/gtools_3.5.0.tar.gz \
         http://cran.r-project.org/src/contrib/gdata_2.18.0.tar.gz \
         http://cran.r-project.org/src/contrib/caTools_1.17.1.tar.gz \
         http://cran.r-project.org/src/contrib/gplots_3.0.1.tar.gz \
         http://cran.r-project.org/src/contrib/ROCR_1.0-7.tar.gz; \
    if [ ! -f gtools_3.5.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/gtools/gtools_3.5.0.tar.gz; \
    fi; \
    if [ ! -f gdata_2.18.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/gdata/gdata_2.18.0.tar.gz; \
    fi; \
    if [ ! -f caTools_1.17.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/caTools/caTools_1.17.1.tar.gz; \
    fi; \
    if [ ! -f gplots_3.0.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/gplots/gplots_3.0.1.tar.gz; \
    fi; \
    if [ ! -f ROCR_1.0-7.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/ROCR/ROCR_1.0-7.tar.gz; \
    fi; \
    R CMD INSTALL gtools_3.5.0.tar.gz gdata_2.18.0.tar.gz caTools_1.17.1.tar.gz gplots_3.0.1.tar.gz \
                  ROCR_1.0-7.tar.gz ; \
    wget http://cran.r-project.org/src/contrib/mixtools_1.1.0.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/segmented/segmented_0.5-1.4.tar.gz; \
    if [ ! -f mixtools_1.1.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/mixtools/mixtools_1.1.0.tar.gz; \
    fi; \
    R CMD INSTALL segmented_0.5-1.4.tar.gz mixtools_1.1.0.tar.gz; \
    wget http://cran.r-project.org/src/contrib/lars_1.2.tar.gz; \
    if [ ! -f lars_1.2.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/lars/lars_1.2.tar.gz; \
    fi; \
    wget http://cran.r-project.org/src/contrib/fastICA_1.2-1.tar.gz; \
    if [ ! -f fastICA_1.2-1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/fastICA/fastICA_1.2-1.tar.gz; \
    fi; \
    R CMD INSTALL lars_1.2.tar.gz fastICA_1.2-1.tar.gz; \
    wget http://cran.r-project.org/src/contrib/tsne_0.1-3.tar.gz \
         http://cran.r-project.org/src/contrib/Rtsne_0.13.tar.gz; \
    if [ ! -f tsne_0.1-3.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/tsne/tsne_0.1-3.tar.gz; \
    fi; \
    if [ ! -f Rtsne_0.13.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/Rtsne/Rtsne_0.13.tar.gz; \
    fi; \
    R CMD INSTALL tsne_0.1-3.tar.gz Rtsne_0.13.tar.gz; \
    wget http://cran.r-project.org/src/contrib/fpc_2.1-10.tar.gz \
         http://cran.r-project.org/src/contrib/mclust_5.4.tar.gz \
         http://cran.r-project.org/src/contrib/prabclus_2.2-6.tar.gz \
         http://cran.r-project.org/src/contrib/diptest_0.75-7.tar.gz \
         http://cran.r-project.org/src/contrib/mvtnorm_1.0-6.tar.gz \
         http://cran.r-project.org/src/contrib/kernlab_0.9-25.tar.gz \
         http://cran.r-project.org/src/contrib/DEoptimR_1.0-8.tar.gz \
         http://cran.r-project.org/src/contrib/robustbase_0.92-8.tar.gz \
         http://cran.r-project.org/src/contrib/modeltools_0.2-21.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/flexmix/flexmix_2.3-13.tar.gz \
         http://cran.r-project.org/src/contrib/trimcluster_0.1-2.tar.gz; \
    if [ ! -f fpc_2.1-10.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/fpc/fpc_2.1-10.tar.gz; \
    fi; \
    if [ ! -f mclust_5.4.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/mclust/mclust_5.4.tar.gz; \
    fi; \
    if [ ! -f prabclus_2.2-6.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/prabclus/prabclus_2.2-6.tar.gz; \
    fi; \
    if [ ! -f diptest_0.75-7.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/diptest/diptest_0.75-7.tar.gz; \
    fi; \
    if [ ! -f mvtnorm_1.0-6.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/mvtnorm/mvtnorm_1.0-6.tar.gz; \
    fi; \
    if [ ! -f trimcluster_0.1-2.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/trimcluster/trimcluster_0.1-2.tar.gz; \
    fi; \
    if [ ! -f kernlab_0.9-25.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/kernlab/kernlab_0.9-25.tar.gz; \
    fi; \
    if [ ! -f DEoptimR_1.0-8.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/DEoptimR/DEoptimR_1.0-8.tar.gz; \
    fi; \
    if [ ! -f robustbase_0.92-8.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/robustbase/robustbase_0.92-8.tar.gz; \
    fi; \
    if [ ! -f modeltools_0.2-21.tar.gz  ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/modeltools/modeltools_0.2-21.tar.gz; \
    fi; \
    R CMD INSTALL mvtnorm_1.0-6.tar.gz diptest_0.75-7.tar.gz mclust_5.4.tar.gz prabclus_2.2-6.tar.gz \
                  kernlab_0.9-25.tar.gz trimcluster_0.1-2.tar.gz DEoptimR_1.0-8.tar.gz robustbase_0.92-8.tar.gz \
                  modeltools_0.2-21.tar.gz flexmix_2.3-13.tar.gz fpc_2.1-10.tar.gz; \
    wget http://cran.r-project.org/src/contrib/ape_5.0.tar.gz; \
    if [ ! -f ape_5.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/ape/ape_5.0.tar.gz; \
    fi; \
    R CMD INSTALL ape_5.0.tar.gz; \
    wget http://cran.r-project.org/src/contrib/pbapply_1.3-3.tar.gz; \
    if [ ! -f pbapply_1.3-3.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/pbapply/pbapply_1.3-3.tar.gz; \
    fi; \
    R CMD INSTALL pbapply_1.3-3.tar.gz; \
    wget http://cran.r-project.org/src/contrib/irlba_2.3.1.tar.gz \
         http://cran.r-project.org/src/contrib/pkgconfig_2.0.1.tar.gz \
         http://cran.r-project.org/src/contrib/igraph_1.1.2.tar.gz; \
    if [ ! -f irlba_2.3.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/irlba/irlba_2.3.1.tar.gz; \
    fi; \
    if [ ! -f pkgconfig_2.0.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/pkgconfig/pkgconfig_2.0.1.tar.gz; \
    fi; \
    if [ ! -f igraph_1.1.2.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/igraph/igraph_1.1.2.tar.gz; \
    fi; \
    R CMD INSTALL irlba_2.3.1.tar.gz pkgconfig_2.0.1.tar.gz igraph_1.1.2.tar.gz; \
    wget http://cran.r-project.org/src/contrib/FNN_1.1.tar.gz; \
    if [ ! -f FNN_1.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/FNN/FNN_1.1.tar.gz; \
    fi; \
    R CMD INSTALL FNN_1.1.tar.gz; \
    wget http://cran.r-project.org/src/contrib/RcppEigen_0.3.3.3.1.tar.gz \
         http://cran.r-project.org/src/contrib/RcppProgress_0.4.tar.gz; \
    if [ ! -f RcppEigen_0.3.3.3.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/RcppEigen/RcppEigen_0.3.3.3.1.tar.gz; \
    fi; \
    if [ ! -f RcppProgress_0.4.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/RcppProgress/RcppProgress_0.4.tar.gz; \
    fi; \
    R CMD INSTALL RcppEigen_0.3.3.3.1.tar.gz RcppProgress_0.4.tar.gz; \
    wget http://cran.r-project.org/src/contrib/ranger_0.8.0.tar.gz; \
    if [ ! -f ranger_0.8.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/ranger/ranger_0.8.0.tar.gz; \
    fi; \
    R CMD INSTALL ranger_0.8.0.tar.gz; \
    wget http://cran.r-project.org/src/contrib/mnormt_1.5-5.tar.gz \
         http://cran.r-project.org/src/contrib/numDeriv_2016.8-1.tar.gz \
         http://cran.r-project.org/src/contrib/sn_1.5-1.tar.gz \
         http://cran.r-project.org/src/contrib/tclust_1.3-1.tar.gz; \
    if [ ! -f mnormt_1.5-5.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/mnormt/mnormt_1.5-5.tar.gz; \
    fi; \
    if [ ! -f numDeriv_2016.8-1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/numDeriv/numDeriv_2016.8-1.tar.gz; \
    fi; \
    if [ ! -f sn_1.5-1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/sn/sn_1.5-1.tar.gz; \
    fi; \
    if [ ! -f tclust_1.3-1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/tclust/tclust_1.3-1.tar.gz; \
    fi; \
    R CMD INSTALL mnormt_1.5-5.tar.gz numDeriv_2016.8-1.tar.gz sn_1.5-1.tar.gz tclust_1.3-1.tar.gz; \
    wget http://cran.r-project.org/src/contrib/ModelMetrics_1.1.0.tar.gz; \
    if [ ! -f ModelMetrics_1.1.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/ModelMetrics/ModelMetrics_1.1.0.tar.gz; \
    fi; \
    R CMD INSTALL ModelMetrics_1.1.0.tar.gz; \
    wget http://cran.r-project.org/src/contrib/purrr_0.2.4.tar.gz \
         http://cran.r-project.org/src/contrib/glue_1.2.0.tar.gz \
         http://cran.r-project.org/src/contrib/tidyselect_0.2.3.tar.gz \
         http://cran.r-project.org/src/contrib/tidyr_0.7.2.tar.gz \
         http://cran.r-project.org/src/contrib/psych_1.7.8.tar.gz \
         http://cran.r-project.org/src/contrib/broom_0.4.3.tar.gz; \
    if [ ! -f purrr_0.2.4.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/purrr/purrr_0.2.4.tar.gz; \
    fi; \
    if [ ! -f glue_1.2.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/glue/glue_1.2.0.tar.gz; \
    fi; \
    if [ ! -f tidyselect_0.2.3.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/tidyselect/tidyselect_0.2.3.tar.gz; \
    fi; \
    if [ ! -f tidyr_0.7.2.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/tidyr/tidyr_0.7.2.tar.gz; \
    fi; \
    if [ ! -f psych_1.7.8.tar.gz  ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/psych/psych_1.7.8.tar.gz ; \
    fi; \
    if [ ! -f broom_0.4.3.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/broom/broom_0.4.3.tar.gz; \
    fi; \
    R CMD INSTALL purrr_0.2.4.tar.gz glue_1.2.0.tar.gz tidyselect_0.2.3.tar.gz \
                  tidyr_0.7.2.tar.gz psych_1.7.8.tar.gz broom_0.4.3.tar.gz; \
    wget http://cran.r-project.org/src/contrib/lava_1.5.1.tar.gz \
         http://cran.r-project.org/src/contrib/prodlim_1.6.1.tar.gz \
         http://cran.r-project.org/src/contrib/ipred_0.9-6.tar.gz; \
    if [ ! -f lava_1.5.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/lava/lava_1.5.1.tar.gz; \
    fi; \
    if [ ! -f prodlim_1.6.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/prodlim/prodlim_1.6.1.tar.gz ; \
    fi; \
    if [ ! -f ipred_0.9-6.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/ipred/ipred_0.9-6.tar.gz; \
    fi; \
    R CMD INSTALL lava_1.5.1.tar.gz prodlim_1.6.1.tar.gz ipred_0.9-6.tar.gz;\
    wget http://cran.r-project.org/src/contrib/CVST_0.2-1.tar.gz \
         http://cran.r-project.org/src/contrib/DRR_0.0.2.tar.gz \
         http://cran.r-project.org/src/contrib/dimRed_0.1.0.tar.gz; \
    if [ ! -f CVST_0.2-1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/CVST/CVST_0.2-1.tar.gz; \
    fi; \
    if [ ! -f DRR_0.0.2.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/DRR/DRR_0.0.2.tar.gz ; \
    fi; \
    if [ ! -f dimRed_0.1.0.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/dimRed/dimRed_0.1.0.tar.gz; \
    fi; \
    R CMD INSTALL CVST_0.2-1.tar.gz DRR_0.0.2.tar.gz dimRed_0.1.0.tar.gz;\
    wget http://cran.r-project.org/src/contrib/sfsmisc_1.1-1.tar.gz \
         http://cran.r-project.org/src/contrib/ddalpha_1.3.1.tar.gz; \
    if [ ! -f ddalpha_1.3.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/ddalpha/ddalpha_1.3.1.tar.gz ; \
    fi; \
    if [ ! -f sfsmisc_1.1-1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/sfsmisc/sfsmisc_1.1-1.tar.gz; \
    fi; \
    R CMD INSTALL sfsmisc_1.1-1.tar.gz ddalpha_1.3.1.tar.gz;\
    wget http://cran.r-project.org/src/contrib/lubridate_1.7.1.tar.gz; \
    if [ ! -f lubridate_1.7.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/lubridate/lubridate_1.7.1.tar.gz; \
    fi; \
    R CMD INSTALL lubridate_1.7.1.tar.gz; \
    wget http://cran.r-project.org/src/contrib/timeDate_3042.101.tar.gz; \
    if [ ! -f timeDate_3042.101.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/timeDate/timeDate_3042.101.tar.gz; \
    fi; \
    R CMD INSTALL timeDate_3042.101.tar.gz; \
    wget http://cran.r-project.org/src/contrib/gower_0.1.2.tar.gz; \
    if [ ! -f gower_0.1.2.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/gower/gower_0.1.2.tar.gz; \
    fi; \
    R CMD INSTALL gower_0.1.2.tar.gz; \
    wget http://cran.r-project.org/src/contrib/RcppRoll_0.2.2.tar.gz; \
    if [ ! -f RcppRoll_0.2.2.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/RcppRoll/RcppRoll_0.2.2.tar.gz; \
    fi; \
    R CMD INSTALL RcppRoll_0.2.2.tar.gz; \
    wget http://cran.r-project.org/src/contrib/recipes_0.1.1.tar.gz; \
    if [ ! -f recipes_0.1.1.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/recipes/recipes_0.1.1.tar.gz; \
    fi; \
    R CMD INSTALL recipes_0.1.1.tar.gz; \
    wget http://cran.r-project.org/src/contrib/codetools_0.2-15.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/iterators/iterators_1.0.8.tar.gz \
         http://cran.r-project.org/src/contrib/Archive/foreach/foreach_1.4.3.tar.gz; \
    if [ ! -f codetools_0.2-15.tar.gz ]; \
    then wget http://cran.r-project.org/src/contrib/Archive/codetools/codetools_0.2-15.tar.gz; \
    fi; \
    R CMD INSTALL codetools_0.2-15.tar.gz iterators_1.0.8.tar.gz foreach_1.4.3.tar.gz;\
    wget http://cran.r-project.org/src/contrib/Archive/caret/caret_6.0-77.tar.gz; \
    R CMD INSTALL caret_6.0-77.tar.gz; \
    wget  http://cran.r-project.org/src/contrib/Archive/cowplot/cowplot_0.9.1.tar.gz \
          http://cran.r-project.org/src/contrib/Archive/VGAM/VGAM_1.0-3.tar.gz; \
    R CMD INSTALL VGAM_1.0-3.tar.gz cowplot_0.9.1.tar.gz ; \
    wget http://github.com/satijalab/seurat/archive/v2.0.0.900.tar.gz; \
    R CMD INSTALL v2.0.0.900.tar.gz; \
    rm *.tar.gz; \
    apt-get remove --purge --yes wget; \
    apt-get clean;
