#!/bin/bash
echo 'Installing Section 2: Computational Basis ...'
$HOME/miniconda2/bin/conda create -y --name section2 python=3
source $HOME/miniconda2/bin/activate section2
pip install https://github.com/datalad/datalad/archive/0.10.0.rc5.zip \
    https://github.com/datalad/datalad-container/archive/master.zip \
    https://github.com/datalad/datalad-neuroimaging/archive/master.zip
source $HOME/miniconda2/bin/deactivate