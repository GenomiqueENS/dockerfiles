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

# Install wget
RUN yum -y install wget

# Download Bcl2FastQ
RUN cd /tmp ; wget ftp://webdata:webdata@ussd-ftp.illumina.com/Downloads/Software/bcl2fastq/bcl2fastq-1.8.4-Linux-x86_64.rpm

# Install OLB dependencies
RUN yum -y --nogpgcheck localinstall /tmp/bcl2fastq-*.rpm

# Cleanup
RUN rm -rf /tmp/*.rpm
