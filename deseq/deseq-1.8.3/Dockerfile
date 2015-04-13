############################################################
# Dockerfile to build DESeq container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren

# Add CRAN source to apt
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu precise/" > /etc/apt/sources.list.d/cran.list

# Add CRAN apt key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Update the repository sources list
RUN apt-get update

# Install Latex
RUN apt-get install --yes texlive-latex-base texlive-latex-extra 

# Install libxml2 
RUN apt-get install --yes libxml2-dev

# Install R 2.15
RUN apt-get install --yes r-base=2.15.0-1precise0 r-base-core=2.15.0-1precise0 r-base-dev=2.15.0-1precise0 r-base-html=2.15.0-1precise0 r-recommended=2.15.0-1precise0 r-base=2.15.0-1precise0 r-base-core=2.15.0-1precise0 r-base-dev=2.15.0-1precise0 r-base-html=2.15.0-1precise0 r-cran-boot=1.3-4-1precise0 r-cran-class=7.3-3-1precise0 r-cran-cluster=1.14.2-1precise0 r-cran-codetools=0.2-8-1precise0 r-cran-foreign=0.8.50-1precise0 r-cran-kernsmooth=2.23-7-1precise0 r-cran-lattice=0.20-6-1precise0 r-cran-mass=7.3-18-1precise0 r-cran-matrix=1.0-6-1precise0 r-cran-mgcv=1.7-17-1precise0 r-cran-rpart=3.1.52-1precise0 r-doc-html=2.15.0-1precise0 r-recommended=2.15.0-1precise0 r-cran-nlme=3.1.104-1precise0 r-cran-survival=2.36-14-1precise0 r-cran-nnet=7.3-1-2precise0 r-cran-spatial=7.3-3-1precise0

# Install DESeq dependencies
RUN apt-get install --yes wget
RUN wget http://cran.r-project.org/src/contrib/Archive/DBI/DBI_0.2-5.tar.gz
RUN wget http://cran.r-project.org/src/contrib/Archive/RSQLite/RSQLite_0.11.1.tar.gz
RUN wget http://cran.r-project.org/src/contrib/Archive/FactoMineR/FactoMineR_1.20.tar.gz
RUN wget http://cran.r-project.org/src/contrib/Archive/ellipse/ellipse_0.3-7.tar.gz
RUN wget http://cran.r-project.org/src/contrib/Archive/scatterplot3d/scatterplot3d_0.3-33.tar.gz
RUN wget http://cran.r-project.org/src/contrib/Archive/locfit/locfit_1.5-8.tar.gz
RUN wget http://cran.r-project.org/src/contrib/Archive/akima/akima_0.5-7.tar.gz
RUN wget http://cran.r-project.org/src/contrib/Archive/xtable/xtable_1.7-0.tar.gz
RUN wget http://cran.r-project.org/src/contrib/Archive/RColorBrewer/RColorBrewer_1.0-5.tar.gz
RUN R CMD INSTALL DBI_0.2-5.tar.gz
RUN R CMD INSTALL RSQLite_0.11.1.tar.gz
RUN R CMD INSTALL scatterplot3d_0.3-33.tar.gz
RUN R CMD INSTALL ellipse_0.3-7.tar.gz
RUN R CMD INSTALL FactoMineR_1.20.tar.gz
RUN R CMD INSTALL akima_0.5-7.tar.gz
RUN R CMD INSTALL locfit_1.5-8.tar.gz
RUN R CMD INSTALL xtable_1.7-0.tar.gz
RUN R CMD INSTALL RColorBrewer_1.0-5.tar.gz
RUN rm DBI_0.2-5.tar.gz RSQLite_0.11.1.tar.gz FactoMineR_1.20.tar.gz ellipse_0.3-7.tar.gz scatterplot3d_0.3-33.tar.gz locfit_1.5-8.tar.gz akima_0.5-7.tar.gz xtable_1.7-0.tar.gz RColorBrewer_1.0-5.tar.gz


# Set CRAN repository to use
RUN echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile

# Install bioconductor
# Force Bioconductor 2.10 version
RUN wget http://bioconductor.org/biocLite.R
RUN sed -i 's/\"2.11"/"2.10"/' biocLite.R
#RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("DESeq")'
RUN R -e 'source("biocLite.R"); biocLite("DESeq")'
RUN rm biocLite.R

# Cleanup
RUN apt-get remove --purge --yes wget
RUN apt-get clean

# Default command to execute at startup of the container
CMD R --no-save
