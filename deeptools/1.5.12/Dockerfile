############################################################
# Dockerfile to build deeptools container image
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM genomicpariscentre/kentutils:302.1.0

# File Author / Maintainer
MAINTAINER Laurent Jourdren

# Install dependencies
RUN apt-get update && \
    apt-get install --yes python-numpy \
                          python-scipy \
                          python-pip \
                          libfreetype6-dev \
                          libpng12-dev \
			  wget




			  #libkrb5-3


# Create a temporary symlink for ft2build.h required deeptools compilation
# Compile deeptools and remove temporary symlink
RUN ln -s freetype2/ft2build.h /usr/include/ft2build.h && \
    pip install 'deeptools==1.5.12' && \
    rm /usr/include/ft2build.h


