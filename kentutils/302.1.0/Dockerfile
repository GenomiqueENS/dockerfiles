#################################################################
# Dockerfile to build kentUtils container image
# Based on Ubuntu 14.04
##################################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File/Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Install dependencies
RUN apt-get update && apt-get install --yes git \
                                            build-essential \
                                            libz-dev libssl-dev \
                                            openssl \
                                            libpng12-dev \
                                            mysql-client  \
                                            libmysqlclient-dev

# Compile and install kentUtils
RUN cd /tmp && \
    git clone https://github.com/ENCODE-DCC/kentUtils.git && \
    cd kentUtils && \
    git checkout  v302.1.0 && \
    make && \
    cp -rp bin/* /usr/local/bin && \
    cd .. && rm -rf kentUtils

# Create UCSC public MySQL server configuration
RUN echo "db.host=genome-mysql.cse.ucsc.edu\ndb.user=genomep\ndb.password=password" > /root/.hg.conf

