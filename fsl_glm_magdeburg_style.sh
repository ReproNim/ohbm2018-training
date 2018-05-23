#!/bin/bash

#
# THIS IS UNFINISHED WORK, PLEASE IGNORE
#

set -e -u

# remember the original directory, just to make some admin parts easier
# but generally irrelevant
srcdir=$(pwd)
wdir=$(mktemp -d) 
cd ${wdir}
echo "Workdir at ${wdir}/localizerdemo"

# prep faux raw data files (no repos yet)

# pull down demo dataset
datalad install -s https://github.com/datalad/example-dicom-functional.git demo_func
# put DICOM in a tarball -- they are typically born this way 
tar -C demo_func -czf s02_study_dicoms.tar.gz dicoms
# clever experiment produces stimulation log in events.tsv format already
cp demo_func/events.tsv s02_log.tsv

# remove demo data repo, we start from a tarball and a log file
datalad remove --nocheck demo_func

# =========================
# XXX actual demo from here

# -- part 0: RAWRAW data ---
# assemble all data artifacts as the were produced in a dataset that
# represents the state of data acquisition that cannot be reproduced
# without from scratch re-acquisition

TODO

# -- part 1: DICOM conversion ---

TODO

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
