#!/bin/bash
echo 'Adding NeuroDebian repository ...'
wget -O- http://neuro.debian.net/lists/xenial.us-nh.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9

echo 'Adding R repository ...'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'

echo 'Installing emacs repository ...'
sudo add-apt-repository ppa:kelleyk/emacs

sudo apt-get update

echo 'Adding sundry editor/vcs tools ...'
sudo apt-get install -y git vim gedit nano dos2unix git-annex-standalone r-base \
    libjpeg62 emacs25

echo 'Adding R-Studio ...'
cd ~
wget https://download1.rstudio.org/rstudio-xenial-1.1.453-amd64.deb
sudo dpkg -i rstudio-xenial-1.1.453-amd64.deb
rm rstudio-xenial-1.1.453-amd64.deb