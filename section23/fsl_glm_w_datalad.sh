#!/bin/bash

if [ -z "$FSLDIR" ]; then
	echo "No FSL found, make sure FSLDIR is set"
	exit 1
fi

set -e -u

# remember the original directory, just to make some admin parts easier
# but generally irrelevant
srcdir=$(pwd)
wdir=$(mktemp -d) 
cd ${wdir}
echo "Demo dataset at ${wdir}/localizerdemo"

# =========================
# XXX actual demo from here

# any analysis starts with a dataset
datalad create localizerdemo
# running everything from the root of a dataset enables the consistent
# use of relative paths in all analysis code and makes an analysis
# implementation more portable
cd localizerdemo

# install input data as a subdataset, to enable identity tracking
# an automated content retrieval, if necessary
#datalad install -d. -s https://github.com/datalad/example-dicom-functional.git inputs/rawdata
datalad install -d. -s /home/mih/dicom_demo/functional inputs/rawdata

# convention: put all code in a code/ directory
mkdir -p code

# XXX next line only needed for this demo generator
cp ${srcdir}/scripts/events2ev3.sh code/

# track any code with Git, as in any other source code repository
datalad add --to-git code/ -m "Script to convert BIDS events.tsv files to FSL EV3 files"

# with `datalad run` we can capture basic provenance information on any
# analysis step: what files where produced by which command, based on
# what kind and state of input data
# here we convert BIDS events.tsv 
datalad run -m 'Build FSL EV3 design files' bash code/events2ev3.sh sub-02 inputs/rawdata/events.tsv

datalad run -m "Convert DICOMs to NIfTI" dcm2niix -b y -o sub-02 inputs/rawdata/dicoms

# XXX next line only needed for this demo generator
sed -e "s,##BASEPATH##,$(pwd),g" ${srcdir}/scripts/ffa_design.fsf > sub-02/1stlvl_design.fsf

# track FSL FEAT analysis configuration in Git as well
datalad add --to-git sub-02/*.fsf -m "FSL FEAT analysis config script"

# execute GLM analysis, this will capture the entire FSL output with
# datalad
# XXX if you are running this in a PY3 virtual-env FSL might break, as
# some scripts are/were PY2 only (in FSL itself; e.g. imglob)
datalad run feat sub-02/1stlvl_design.fsf

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
