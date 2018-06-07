#!/bin/bash
echo 'Installing Section 1: FAIR Data - BIDS datasets ...'

# The Indiv_Diffs_ReadingSkill.tar file was downloaded from:
# https://openneuro.org/datasets/ds001365/versions/00001

cd ~
sudo apt-get -y install graphviz

$HOME/miniconda2/bin/conda create -y --name section1 python=3
source $HOME/miniconda2/bin/activate section1
pip install pytest graphviz requests rdflib fuzzywuzzy \
    python-levenshtein pygithub pandas owlready2 pybids duecredit \
    https://github.com/incf-nidash/PyNIDM/archive/a90b3f47dbdafb9504f13a3a8d85fdff931cc45c.zip
git clone https://github.com/incf-nidash/PyNIDM.git
cd PyNIDM
pip install -e .
mkdir ~/workspace
cd ~/workspace
tar -xvf ~/Downloads/Indiv*.tar
cd ~/workspace/Indiv_Diffs_ReadingSkill
~/PyNIDM/bin/BIDSMRI2NIDM.py -d ~/workspace/Indiv_Diffs_ReadingSkill
cd ~
git clone https://github.com/albertcrowley/nidm-training.git
source $HOME/miniconda2/bin/deactivate