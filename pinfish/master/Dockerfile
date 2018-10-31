FROM ubuntu:18.04

MAINTAINER Laffay Berengere <laffay@biologie.ens.fr>

RUN apt-get update && \
    apt-get install --yes apt-utils &&\
    apt-get install --yes wget &&\
    apt --yes upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes \
        git && \
    echo '* apt install finished *' &&\
    cd /tmp && \
    wget https://dl.google.com/go/go1.10.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xvzf go1.10.4.linux-amd64.tar.gz && \
    echo '* wget and tar go 1.7 finished *'
     
ENV PATH=$PATH:/usr/local/go/bin

RUN export GOROOT=/usr/local/go && \
    go get github.com/biogo/biogo/ && \
    go get github.com/biogo/hts/sam && \
    go get github.com/google/uuid && \
    go get gonum.org/v1/gonum/stat && \
    cd /tmp && \
    git clone https://github.com/nanoporetech/pinfish.git && \
# Add make in the subdirectory
    cd /tmp/pinfish/spliced_bam2gff &&\
    go build -ldflags "-X main.Version=0.1.0 -X main.Build=`git rev-parse HEAD`" -o spliced_bam2gff  && \
    cd /tmp/pinfish/cluster_gff &&\
    go build -ldflags "-X main.Version=0.1.0 -X main.Build=`git rev-parse HEAD`" -o /cluster_gff && \
    cd /tmp/pinfish/polish_clusters &&\
    go build -ldflags "-X main.Version=0.1.0 -X main.Build=`git rev-parse HEAD`" -o collapse_partials && \


