# Set the base image to CentOS 6
FROM centos:6

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Install Bcl2fastq 
RUN yum -y install wget unzip && \
    cd /tmp && \
    wget --no-check-certificate https://support.illumina.com/content/dam/illumina-support/documents/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-linux-x86-64.zip && \
    unzip *.zip && \
    yum -y --nogpgcheck localinstall /tmp/bcl2fastq2-*.rpm && \
    yum -y remove  wget && \
    rm -rf /tmp/*.rpm 
