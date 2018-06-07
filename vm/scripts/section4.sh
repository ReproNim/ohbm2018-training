#!/bin/bash
echo 'Installing Section 4: Statistics ...'

cd ~
$HOME/miniconda2/bin/conda create -y --name section4 python=3
source $HOME/miniconda2/bin/activate section4
pip install -r ~/requirements.txt # File copied into VM via Packer provider
git clone https://github.com/regreg/regreg.git
cd regreg
pip install .
source $HOME/miniconda2/bin/deactivate
cd ~
rm ~/requirements.txt
rm -rf ~/regreg