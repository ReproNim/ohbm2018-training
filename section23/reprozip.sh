#!/bin/bash
# Now let's switch gears a little bit to record provenance slightly differently
mkdir reprozip
cd reprozip

# Let's get a new dataset
datalad install ///openfmri/ds000114

# and retrieve only the T1s from one participant
datalad get sub-02/ses-*test/anat/sub-02_ses-*test_T1w.nii.gz

# Now we will use a tool called reprozip
datalad run singularity exec -B /tmp --bind $PWD/. -H $PWD/. \
 ../glm_analysis/.datalad/environments/fsl/image \
 reprozip trace bet \
 ./ds000114/sub-02/ses-test/anat/sub-02_ses-test_T1w.nii.gz brain -m
singularity exec -B /tmp --bind $PWD/. -H $PWD/. \
 ../glm_analysis/.datalad/environments/fsl/image reprozip pack

# and now let's look at the information stored
reprounzip info experiment.rpz
reprounzip showfiles experiment.rpz

# reprozip can be used to rerun the analysis in a different place
reprounzip docker setup experiment.rpz repeat

cd ../glm-analysis

# how would we use reprozip to capture the details of the glm
datalad run singularity exec -B /tmp --bind /nobackup/scratch/Fri/satra/training/test-exercises/demo/glm_analysis/. -H /nobackup/scratch/Fri/satra/training/test-exercises/demo/glm_analysis/. .datalad/environments/fsl/image reprozip trace feat 'sub-02/1stlvl_design.fsf'
