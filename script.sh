#####################################################################
# Condor installation script for ubuntu
# Source code: https://github.com/FXIhub/condor.git
# Documentation: https://lmb.icm.uu.se/condor/static/docs/index.html
# Author- Keshav
# Public Domain
#####################################################################


#!/bin/sh

#################################################################
echo "Install build and runtime dependecies"
sudo apt --yes install libfftw3-bin libfftw3-dev libtool cmake \
	libpng-dev libtiff-dev automake autotools-dev libsz2 \
	hdf5-tools libhdf5-dev libgsl23 libgsl-dev gsl-bin \
	libpcre3 libpcre3-dev swig git
clear

echo "Installing python modules"
sudo apt --yes install python3-numpy python3-scipy python3-h5py \
	python3-dev python3-matplotlib python3-pip
clear
################################################################

echo "Making a new directory to download all the repositories"
mkdir condor_installation
cd condor_installation
root_dir=$(pwd)
clear
###############################################################

echo "Installing NFFT"
git clone https://github.com/NFFT/nfft.git
cd nfft
./bootstrap.sh
./configure --enable-all
make
sudo make install
cd $root_dir
clear
##############################################################

echo "Installing libspimage and spsim"

# installig libspimage
git clone https://github.com/FXIhub/libspimage.git
cd libspimage
mkdir build
cd build
cmake ..
make
sudo make install
cd $root_dir

# installing spsim

git clone https://github.com/FXIhub/spsim.git
cd spsim
mkdir build
cd build
cmake ..
make
sudo make install
cd $root_dir
clear
#########################################################

echo "Now, installing condor"

git clone https://github.com/FXIhub/condor.git
cd condor
sudo python3 setup.py install
cd $root_dir
clear
#######################################################

# Setting up bash enviroment for python

echo "alias python='python3'" >> ~/.bashrc

echo "Now everything is done, enjoy your installation."
