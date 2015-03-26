############################################################
# Dockerfile to build bcl2fastq container images
# Based on CentOS images made by fatherlinux
# fatherlinux is a RedHat developer
# http://developerblog.redhat.com/2014/05/15/practical-introduction-to-docker-containers/
############################################################

# Set the base image to CentOS 5
FROM centos:5

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Download Bcl2FastQ
ADD http://transcriptome.ens.fr/leburon/downloads/illumina/bcl2fastq2-v2.16.0.10-Linux-x86_64.rpm /tmp/

# Install OLB dependencies
RUN yum -y --nogpgcheck localinstall /tmp/bcl2fastq2-*.rpm

# Cleanup
RUN rm -rf /tmp/*.rpm
