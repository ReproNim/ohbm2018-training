#!/bin/bash
echo 'Installing Miniconda ...'
cd ~
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh -b
rm Miniconda2-latest-Linux-x86_64.sh
echo 'export PATH=$HOME/miniconda2/bin:$PATH' >> ~/.bashrc