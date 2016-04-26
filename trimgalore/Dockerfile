###########################################################
# Dockerfile to build image for Trim Galore! step in eoulsan
# Based on Ubuntu
###########################################################


# Set the base image to Ubuntu
FROM ubuntu:14.04


# Update the repository sources list
RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install python
RUN apt-get -y install gzip

# Install cutadapt 
WORKDIR /tmp/

RUN wget https://github.com/ComputationalSystemsBiology/EoulsanDockerFiles/raw/master/TrimAdapt/cutadapt-1.8.1.tar.gz

RUN tar -xzf cutadapt-1.8.1.tar.gz

# Install Trim_Galore

RUN wget https://github.com/ComputationalSystemsBiology/EoulsanDockerFiles/raw/master/TrimAdapt/trim_galore_v0.4.1.zip

RUN apt-get install unzip

RUN unzip trim_galore_v0.4.1.zip -d .

RUN ln -s /tmp/trim_galore_zip/trim_galore /usr/local/bin/

# creating a script to rename the output

WORKDIR /


RUN touch RenameOutput.sh
RUN printf "#!/bin/bash\n" >> RenameOutput.sh
RUN printf 'ls $1 | sed --expression="s/\([^\.]*\)\(.*\)/\\' >> RenameOutput.sh
RUN printf '1_trimmed\\' >> RenameOutput.sh
RUN printf '2/" | xargs -Ifullname basename fullname | xargs -Imyname mv `dirname $2`/myname $2 \n' >> RenameOutput.sh
RUN chmod +x RenameOutput.sh

RUN touch RenameOutput2.sh
RUN printf "#!/bin/bash\n" >> RenameOutput2.sh
RUN printf 'ls $1 | sed --expression="s/\([^\.]*\)\(.*\)/\\' >> RenameOutput2.sh
RUN printf '1_val_1\\' >> RenameOutput2.sh
RUN printf '2/" | xargs -Ifullname basename fullname | xargs -Imyname mv `dirname $2`/myname $2 \n' >> RenameOutput2.sh
RUN chmod +x RenameOutput2.sh

RUN touch RenameOutput3.sh
RUN printf "#!/bin/bash\n" >> RenameOutput3.sh
RUN printf 'ls $1 | sed --expression="s/\([^\.]*\)\(.*\)/\\' >> RenameOutput3.sh
RUN printf '1_val_2\\' >> RenameOutput3.sh
RUN printf '2/" | xargs -Ifullname basename fullname | xargs -Imyname mv `dirname $2`/myname $2 \n' >> RenameOutput3.sh
RUN chmod +x RenameOutput3.sh 


