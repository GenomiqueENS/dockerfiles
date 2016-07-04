#############################################################
# Dockerfile to build image for Bed to BigBed step in eoulsan
# Based on Ubuntu
#############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# Update the repository sources list
RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install python
RUN apt-get -y install gzip
RUN apt-get -y install heimdall-flash heimdall-flash-frontend

WORKDIR /tmp

RUN wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedToBigBed
RUN wget https://raw.githubusercontent.com/ENCODE-DCC/kentUtils/master/src/hg/lib/encode/narrowPeak.as
RUN wget https://raw.githubusercontent.com/igvteam/igv/master/resources/chromSizes/mm10.chrom.sizes
RUN wget https://genome.ucsc.edu/goldenPath/help/hg19.chrom.sizes
RUN wget https://genome.ucsc.edu/goldenPath/help/hg38.chrom.sizes

RUN chmod +x bedToBigBed

RUN sed '13d' narrowPeak.as > broadPeak.as

WORKDIR /

RUN touch awkCommand.sh
RUN printf "#!/bin/bash\n" >> awkCommand.sh
RUN printf "awk 'NR == FNR {if(max < \$5) {max = \$5}; next} OFS=\"\t\" {\$5 = int(\$5 / max * 1000)}1' \$1 \$1 > \$2" >> awkCommand.sh
RUN chmod +x awkCommand.sh

