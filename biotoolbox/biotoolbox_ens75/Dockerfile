############################################################
# Dockerfile to build biotoolbox with ensembl75 api container images
# Based on genomicpariscentre/bioperl
############################################################

# Set the base image to Ubuntu
FROM genomicpariscentre/bioperl   

# File Author / Maintainer
MAINTAINER Sophie Lemoine <slemoine@biologie.ens.fr>

# Update the repository sources list
RUN apt-get update

#Install ensembl api  75
RUN apt-get install -y git
WORKDIR /usr/local/
#RUN git clone https://github.com/Ensembl/ensembl-git-tools.git
#ENV PATH /usr/local/ensembl-git-tools/bin:$PATH
#RUN ln -s /usr/local/ensembl-git-tools/bin/* /usr/local/bin
RUN git clone https://github.com/Ensembl/ensembl.git
WORKDIR /usr/local/ensembl/
#RUN git ensembl --checkout --branch release/75 api
RUN git checkout release/75
ENV PERL5LIB /usr/local/ensembl/modules:${PERL5LIB}

# Install Samtools
RUN apt-get install  --yes \
 libbam-dev \
 samtools

RUN ln -s /usr/lib/libbam.a /usr/include/samtools/libbam.a

ENV SAMTOOLS /usr/include/samtools

RUN cpanm \
 LDS/Bio-SamTools-1.39.tar.gz
 
# Install JKENT lib from UCSC
RUN apt-get install --yes \
 wget \
 unzip \
 sed

# Install JKENT lib dependancies
RUN apt-get install --yes \
 libmysqlclient15-dev \
 libpng12-dev mysql-client-5.5 \
 mysql-client-core-5.5


WORKDIR /usr/local 
RUN wget http://hgdownload.cse.ucsc.edu/admin/jksrc.zip
RUN unzip jksrc.zip
RUN rm jksrc.zip

WORKDIR /usr/local/kent/src/
ENV MACHTYPE x86_64
ENV KENT_SRC /usr/local/kent/src

WORKDIR /usr/local/kent/src/lib
RUN make CXXFLAGS=-fPIC CFLAGS=-fPIC CPPFLAGS=-fPIC

WORKDIR /usr/local/kent/src/jkOwnLib
RUN make CXXFLAGS=-fPIC CFLAGS=-fPIC CPPFLAGS=-fPIC

WORKDIR /usr/local/kent/src/inc
RUN  mkdir /usr/local/bin/script; mkdir /usr/local/bin/x86_64
RUN sed -i "s/CFLAGS\=/CFLAGS\=\-fPIC/" common.mk \
 && sed -i "s:BINDIR = \${HOME}/bin/\${MACHTYPE}:BINDIR=/usr/local/bin/\${MACHTYPE}:" common.mk \
 && sed -i "s:SCRIPTS=\${HOME}/bin/scripts:SCRIPTS=/usr/local/bin/scripts:" common.mk 
# && cat common.mk 

WORKDIR /usr/local/kent/src/utils/wigToBigWig
RUN make
WORKDIR /usr/local/kent/src/utils/bedGraphToBigWig
RUN make
WORKDIR /usr/local/kent/src/utils/bedToBigBed
RUN make
WORKDIR /usr/local/kent/src/utils/bigWigInfo
RUN make
WORKDIR /usr/local/kent/src/utils/bigBedInfo
RUN make
WORKDIR /usr/local/kent/src/utils/bigWigToBedGraph
RUN make
WORKDIR /usr/local/kent/src/utils/bigWigToWig
RUN make
WORKDIR /usr/local/kent/src/utils/bigBedToBed 
RUN make
ENV PATH /usr/local/kent/src/utils/wigToBigWig:/usr/local/kent/src/utils/bedGraphToBigWig:/usr/local/kent/src/utils/bedToBigBed: /usr/local/kent/src/utils/bigWigInfo:/usr/local/kent/src/utils/bigBedInfo:$PATH
ENV PATH /usr/local/kent/src/utils/bigWigToBedGraph:/usr/local/kent/src/utils/bigWigToWig:/usr/local/kent/src/utils/bigBedToBed:/usr/local/kent/src/utils/bigBedToBed:$PATH

#Install perl modules related to JKENT lib
RUN apt-get install -y \
 libssl1.0.0 \
 libssl-dev

WORKDIR /tmp
RUN wget http://cpan.metacpan.org/authors/id/L/LD/LDS/Bio-BigFile-1.07.tar.gz
RUN tar xzf Bio-BigFile-1.07.tar.gz
WORKDIR /tmp/Bio-BigFile-1.07
RUN ls -la \
 && sed -i "s/\$ENV{KENT_SRC}/\'\/usr\/local\/kent\/src\'/" Build.PL \
 && sed -i "s/\$ENV{MACHTYPE}/x86_64/" Build.PL \
 && perl Build.PL \
 && ./Build \
 && ./Build test \
 && ./Build install 

#Install Bio::Graphics and Bio::Graphics::Wiggle 
RUN cpanm Bio::Graphics \
 Bio::Graphics::Wiggle
#Install wiggle2gff3.pl
WORKDIR /usr/local/bin
RUN wget http://cpansearch.perl.org/src/LDS/GBrowse-2.54/bin/wiggle2gff3.pl
RUN ls -l



#Install biotoolbox 
RUN cpanm \
 Bio::Root::Version \ 
 Bio::DB::USeq \
 Algorithm::Cluster \
 DBD::SQLite \
 Parallel::ForkManager \
 Statistics::LineFit


RUN cpanm -vf TJPARNELL/Bio-ToolBox-1.23.tar.gz 


