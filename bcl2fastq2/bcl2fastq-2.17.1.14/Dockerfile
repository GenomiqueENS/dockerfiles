# Set the base image to CentOS 5
FROM centos:5
# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Install wget
RUN yum -y install wget

# Download Bcl2FastQ, with this version software, should add 'no-check-certificate' to download file
RUN (cd /tmp && wget --no-check-certificate https://support.illumina.com/content/dam/illumina-support/documents/downloads/software/bcl2fastq/bcl2fastq2-v2.17.1.14-Linux-x86_64.rpm)

# Install OLB dependencies
RUN yum -y --nogpgcheck localinstall /tmp/bcl2fastq2-*.rpm

RUN (cd /usr/local/bin && ln -s ../share/)

# Cleanup
RUN rm -rf /tmp/*.rpm
