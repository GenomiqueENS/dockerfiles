FROM ubuntu:18.04

MAINTAINER Laffay Berengere <laffay@biologie.ens.fr>
RUN apt-get update && \
    apt-get install --yes apt-utils \
        samtools \
        wget &&\
    apt --yes upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes \
        git && \
    echo '* apt install finished *' &&\
    cd /tmp && \
    wget https://dl.google.com/go/go1.10.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xvzf go1.10.4.linux-amd64.tar.gz && \

# Install miniconda to /miniconda
RUN apt-get update && apt-get install -y curl
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

## Install minimap2
RUN conda install -c bioconda minimap2
RUN conda update -c bioconda minimap2

##  Install racon
RUN conda install -c bioconda racon

## Install gffcompare
RUN conda install -c bioconda gffcompare

ENV PATH=$PATH:/usr/local/go/bin

RUN export GOROOT=/usr/local/go && \
    go get github.com/biogo/biogo/ && \
    go get github.com/biogo/hts/sam && \
    go get github.com/google/uuid && \
    go get gonum.org/v1/gonum/stat && \
    cd /tmp && \
    git clone https://github.com/nanoporetech/pinfish.git && \
# Add build project 
    cd /tmp/pinfish/spliced_bam2gff &&\
    go build -ldflags "-X main.Version=0.1.0 -X main.Build=`git rev-parse HEAD`" -o spliced_bam2gff  && \
    cd /tmp/pinfish/cluster_gff &&\
    go build -ldflags "-X main.Version=0.1.0 -X main.Build=`git rev-parse HEAD`" -o cluster_gff && \
    cd /tmp/pinfish/polish_clusters &&\
    go build -ldflags "-X main.Version=0.1.0 -X main.Build=`git rev-parse HEAD`" -o polish_clusters && \
    cd /tmp/pinfish/polish_clusters &&\
    go build -ldflags "-X main.Version=0.1.0 -X main.Build=`git rev-parse HEAD`" -o collapse_partials


WORKDIR /tmp/pinfish/

#Delete and clean unwanted packages
RUN apt remove --purge --yes git build-essential && \
    apt autoremove --purge --yes

