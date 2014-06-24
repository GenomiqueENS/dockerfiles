############################################################
# Dockerfile to build OLB container images
# Based on CentOS images made by fatherlinux
# fatherlinux is a RedHat developer
# http://developerblog.redhat.com/2014/05/15/practical-introduction-to-docker-containers/
############################################################

# Set the base image to CentOS 5
FROM fatherlinux/centos5-base:latest

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Install OLB dependencies
RUN yum -y install perl-XML-Dumper perl-XML-Grove perl-XML-LibXML perl-XML-NamespaceSupport perl-XML-Parser perl-XML-SAX perl-XML-Simple perl-XML-Twig gnuplot ImageMagick ghostscript libxml2 libxml2-devel libxml2-python ncurses ncurses-devel gcc gcc-c++ libtiff libtiff-devel bzip2 bzip2-devel zlib zlib-devel PyXML

# Download OLB
ADD http://supportres.illumina.com/documents/myillumina/9ca47226-7252-4b9b-aef5-4fac02a238c7/olb-1.9.4.tar.gz /tmp/

# Download fftw3
ADD http://www.fftw.org/fftw-3.3.4.tar.gz /tmp/

# Uncompress archives
RUN tar -C /tmp -xzf /tmp/olb-*.tar.gz
RUN tar -C /tmp -xzf /tmp/fftw-*.tar.gz

# Install fftw3
RUN cd /tmp/fftw*/ && ./configure --enable-single && make && make install

# Install OLB
RUN sed 's/set (CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR})/set (CMAKE_INSTALL_PREFIX \/usr\/local)/' /tmp/OLB-*/CMakeLists.txt > /tmp/CMakeLists.txt.new && mv /tmp/CMakeLists.txt.new /tmp/OLB-*/CMakeLists.txt
RUN cd /tmp/OLB-*/ && make install

# Cleanup
RUN rm -rf /tmp/olb* /tmp/OLB*
