#!/bin/bash

set -e -u

# remember the original directory, just to make some admin parts easier
# but generally irrelevant
srcdir=$(pwd)
wdir=$(mktemp -d) 
cd ${wdir}
echo "Workdir at ${wdir}/localizerdemo"

# =========================
# XXX actual demo from here

# -- part 1: DICOM conversion ---

# we are creating a BIDS compatible variant of our MR dataset
datalad create bids
# running everything from the root of a dataset enables the consistent
# use of relative paths in all analysis code and makes an analysis
# implementation more portable
cd bids

# install input data as a subdataset, to enable identity tracking
# an automated content retrieval, if necessary
datalad install -d. -s https://github.com/datalad/example-dicom-functional.git inputs/rawdata

# get a ready-made container with the dicom converter
datalad containers-add heudiconv -u shub://mih/ohbm2018-training:heudiconv

# with `datalad (containers-)run` we can capture basic provenance information on any
# analysis step: what files where produced by which command, based on
# what kind and state of input data
# perform the DICOM conversion
# containers-run will automatically execute this in the registered
# container (no need to think about it)
# --input ensures that datalad will obtain any matching files (if needed)
# --ouput ensure that datalad unlocks any matching files so that
#   the payload command can alter them.
datalad containers-run -m "Convert sub-02 DICOMs into BIDS" \
   --input inputs/rawdata/dicoms \
   --output . \
   heudiconv -f reproin -s 02 -c dcm2niix -b -l '' --minmeta -a . \
       -o /tmp/heudiconv.sub-02 --files inputs/rawdata/dicoms

# Simplify: https://github.com/datalad/datalad/issues/2512
datalad run -m "Import stimulation events" \
   --input inputs/rawdata/events.tsv \
   --output sub-02/func/sub-02_task-oneback_run-01_events.tsv \
   cp inputs/rawdata/events.tsv sub-02/func/sub-02_task-oneback_run-01_events.tsv

# at this point we have a complete BIDS raw dataset in a clean Git repository
# that is reproducible from the raw DICOM file state

cd ..

# -- part 2: (GLM) analysis ---

# any analysis is its own project, as any raw data can be analyzed in many different
# ways

datalad create glm_analysis
cd glm_analysis

# get the BIDS raw dataset (no actual content)
datalad install -d. -s ../bids inputs/rawdata

# convention: put all code in a code/ directory
mkdir -p code

# XXX next line only needed for this demo generator
cp ${srcdir}/scripts/events2ev3.sh code/

# track any code with Git, as in any other source code repository
datalad add --to-git code/ -m "Script to convert BIDS events.tsv files to FSL EV3 files"

# here we convert BIDS events.tsv into a format accessible to FSL
# TODO simplify: https://github.com/datalad/datalad/issues/2512
datalad run -m 'Build FSL EV3 design files' \
    --input inputs/rawdata/sub-02/func/sub-02_task-oneback_run-01_events.tsv \
    --output 'sub-02/onsets' \
    bash code/events2ev3.sh sub-02 inputs/rawdata/sub-02/func/sub-02_task-oneback_run-01_events.tsv

# XXX next line only needed for this demo generator
sed -e "s,##BASEPATH##,$(pwd),g" -e "s,##SUB##,sub-02,g" ${srcdir}/scripts/ffa_design.fsf > sub-02/1stlvl_design.fsf

# track FSL FEAT analysis configuration in Git as well
datalad add --to-git sub-02/*.fsf -m "FSL FEAT analysis config script"

# use a pre-crafter container image for FSL
datalad containers-add fsl -u shub://mih/ohbm2018-training:fsl

# execute GLM analysis, this will capture the entire FSL output with
# datalad
datalad containers-run -m "sub-02 1st-level GLM" \
    --input sub-02/onsets \
    --input sub-02/1stlvl_design.fsf \
    --input inputs/rawdata/sub-02/func/sub-02_task-oneback_run-01_bold.nii.gz \
    --output sub-02/1stlvl_glm.feat \
    feat sub-02/1stlvl_design.fsf

# done

# -- part 3: get ready for the afterlife

# we can now instruct datalad to extract some essential metadata properties
# of the dataset content, more than one extractor can be enabled, here is just
# a demo config call that could be repeated/amended
git config --file .datalad/config --add datalad.metadata.nativetype nifti1
# save this change, a clean dataset is easier on the mind...
datalad save

# with this configuration in place, metadata extraction can be performed
# automatically
datalad aggregate-metadata

# and subsequently we can search for particular dataset content
# e.g. all nifti files that FSL marked as coming from itself
datalad search --mode autofield nifti1.description:fsl5.0

# at this point we have a complete record of this analysis
# we can even ask datalad to export a script of all the steps
# every recorded
datalad rerun --since= --script myanalysis.sh

cat myanalysis.sh
