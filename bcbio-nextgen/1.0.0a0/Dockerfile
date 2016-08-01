################################################
# Docker image for bcbio-nextgen 1.0.0a0       #
################################################

FROM bcbio/bcbio:latest

MAINTAINER Alexandra Bomane "alexandra.bomane@laposte.net"

# Setup a base system 
RUN /usr/local/share/bcbio-nextgen/anaconda/bin/bcbio_nextgen.py upgrade -u development --tools && \
    /usr/local/share/bcbio-nextgen/anaconda/bin/seqcluster_install --upgrade &&\
    ln -s /usr/local/share/bcbio-nextgen/anaconda/bin/seqcluster* /usr/local/bin/.
