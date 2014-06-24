############################################################
# Dockerfile to build casava container images
# Based on CentOS images made by fatherlinux
# fatherlinux is a RedHat developer
# http://developerblog.redhat.com/2014/05/15/practical-introduction-to-docker-containers/
############################################################

# Set the base image to CentOS 5
FROM fatherlinux/centos5-base:latest

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Install OLB dependencies
RUN yum -y install make perl python PyXML gnuplot ImageMagick ghostscript libxslt libxslt-devel libxml2 libxml2-devel libxml2-python ncurses ncurses-devel gcc gcc-c++ libtiff libtiff-devel bzip2 bzip2-devel zlib zlib-devel perl-XML-Dumper perl-XML-Grove perl-XML-LibXML perl-XML-LibXML-Common perl-XML-NamespaceSupport perl-XML-Parser perl-XML-SAX perl-XML-Simple perl-XML-Twig perldoc 

# Download CASAVA
ADD http://supportres.illumina.com/documents/myillumina/6e422abb-dc36-4d09-b223-0eafef26ddc5/casava_v1.8.2.tar /tmp/

# Uncompress CASAVA archive
RUN tar -C /tmp -xjf /tmp/casava*.tar

# Install CASAVA
RUN ln -s /tmp/CASAVA_* /tmp/CASAVA
RUN mkdir /tmp/CASAVA-build && cd /tmp/CASAVA-build && /tmp/CASAVA/src/configure --prefix=/usr/local && make && make install

# Cleanup
RUN rm -rf /tmp/casava* /tmp/CASAVA*
