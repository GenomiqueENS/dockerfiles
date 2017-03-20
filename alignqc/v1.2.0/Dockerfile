###########################################################
# Dockerfile to build AlignQC container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Aurélien Birer <birer@biologie.ens.fr>

# Run AlignQC
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/cran.list && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
 apt-get update && \
 apt install --yes \
 python2.7 \
 r-base=3.3.0-1trusty0 r-base-core=3.3.0-1trusty0 r-base-dev=3.3.0-1trusty0 r-base-html=3.3.0-1trusty0 r-doc-html=3.3.0-1trusty0 r-recommended=3.3.0-1trusty0 r-cran-boot=1.3-15-1trusty0 r-cran-class=7.3-14-1trusty0 r-cran-cluster=2.0.3-1trusty0 r-cran-codetools=0.2-10-1trusty0 r-cran-foreign=0.8.66-1trusty0 r-cran-kernsmooth=2.23-15-1trusty0 r-cran-lattice=0.20-33-1trusty0 r-cran-mass=7.3-44-1trusty0 r-cran-matrix=1.2-6-1trusty0 r-cran-mgcv=1.8-7-1trusty0 r-cran-nlme=3.1.128-1trusty0 r-cran-nnet=7.3-12-1trusty0 r-cran-rpart=4.1-10-1trusty0 r-cran-spatial=7.3-10-1trusty0 r-cran-survival=2.39-4-1trusty0 \
 git && \
 cd /usr/local && \
 git clone https://github.com/jason-weirather/AlignQC.git && \
 cd /usr/local/AlignQC && \
 git checkout v1.2.0 && \
 ln -s /usr/local/AlignQC/bin/alignqc /usr/local/bin/alignqc  && \
 apt remove --yes --purge git && apt autoremove --yes --purge && apt clean

