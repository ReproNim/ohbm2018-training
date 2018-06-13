#!/bin/bash

set -e -u

# remember the original directory, just to make some admin parts easier
# but generally irrelevant
srcdir=$(pwd)
wdir=${1:-demo}
mkdir -p ${wdir}
cd ${wdir}
echo "Workdir at `pwd`"

# Now let's switch gears a little bit to record provenance slightly differently
datalad create reprozip
cd reprozip

# Let's get a new dataset
datalad install -d . -s ///openfmri/ds000114

# and retrieve only the T1s from one participant
datalad get ds000114/sub-02/ses-*test/anat/sub-02_ses-*test_T1w.nii.gz

# Now we will use a tool called reprozip
datalad run singularity exec -B /tmp --bind $PWD/. -H $PWD/. \
 ../glm_analysis/.datalad/environments/fsl/image \
 reprozip trace bet \
 ./ds000114/sub-02/ses-test/anat/sub-02_ses-test_T1w.nii.gz brain -m

datalad run singularity exec -B /tmp --bind $PWD/. -H $PWD/. \
 ../glm_analysis/.datalad/environments/fsl/image reprozip pack

# and now let's look at the information stored
datalad run singularity exec -B /tmp --bind $PWD/. -H $PWD/. \
 ../glm_analysis/.datalad/environments/fsl/image reprounzip info experiment.rpz

datalad run singularity exec -B /tmp --bind $PWD/. -H $PWD/. \
 ../glm_analysis/.datalad/environments/fsl/image reprounzip showfiles experiment.rpz

conda activate section3

# reprozip can be used to rerun the analysis in a different place
reprounzip docker setup experiment.rpz repeat


# how would we use reprozip to capture the details of the glm
conda activate section2

cd ../glm-analysis
datalad run singularity exec -B /tmp --bind $PWD/. -H $PWD/. \
  .datalad/environments/fsl/image reprozip trace feat 'sub-02/1stlvl_design.fsf'
