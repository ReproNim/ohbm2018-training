#!/bin/bash

# section 1
docker run --rm kaczmarj/neurodocker:master generate singularity \
  --base neurodebian:latest --pkg-manager apt \
  --install graphviz git wget \
  --miniconda \
    conda_install="python=3 pytest graphviz pip reprozip reprounzip \
       requests rdflib fuzzywuzzy python-levenshtein pygithub pandas" \
    pip_install="owlready2 pybids duecredit \
     https://github.com/incf-nidash/PyNIDM/archive/a90b3f47dbdafb9504f13a3a8d85fdff931cc45c.zip" \
    create_env="section1" \
    activate=true \
  --run-bash "cd /opt && \
    git clone https://github.com/incf-nidash/PyNIDM.git" > Singularity.PyNIDM

# section 2/3
docker run --rm kaczmarj/neurodocker:master generate singularity  \
  --base neurodebian:stretch-non-free   --pkg-manager apt   \
  --install fsl-5.0-core fsl-mni152-templates \
  --install make gcc sqlite3 libsqlite3-dev python3-dev \
    libc6-dev python3-pip python3-setuptools python3-wheel \
  --run "pip3 install --system reprozip reprounzip" \
  --add-to-entrypoint "source /etc/fsl/5.0/fsl.sh" > Singularity.fsl


docker run --rm kaczmarj/neurodocker:master generate singularity \
  --base neurodebian:latest --pkg-manager apt \
  --install pigz python3-pip python3-traits python3-scipy  \
     python3-setuptools python3-wheel python3-networkx dcm2niix \
  --install make gcc sqlite3 libsqlite3-dev python3-dev libc6-dev \
  --run "pip3 install --system nipype \
    https://github.com/mvdoc/dcmstack/archive/bf/importsys.zip \
    https://github.com/nipy/heudiconv/archive/master.zip \
    reprozip reprounzip" > Singularity.heudiconv

docker run --rm kaczmarj/neurodocker:master generate docker  \
  --base neurodebian:stretch-non-free   --pkg-manager apt   \
  --install fsl-5.0-core fsl-mni152-templates \
  --install make gcc sqlite3 libsqlite3-dev python3-dev \
    libc6-dev python3-pip python3-setuptools python3-wheel \
  --run "pip3 install --system reprozip reprounzip" \
  --add-to-entrypoint "source /etc/fsl/5.0/fsl.sh" > Dockerfile.fsl