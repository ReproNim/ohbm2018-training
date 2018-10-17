#!/bin/bash
echo 'Installing Singularity ...'
VERSION=2.5.1
sudo apt-get install -y libarchive-dev
cd ~
wget https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make
sudo make install
cd ~
rm ~/singularity-$VERSION.tar.gz
rm -rf ~/singularity-$VERSION