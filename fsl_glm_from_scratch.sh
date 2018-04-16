#!/bin/bash

if [ -z "$FSLDIR" ]; then
	echo "No FSL found, make sure FSLDIR is set"
	exit 1
fi

#git clone https://github.com/datalad/example-dicom-functional.git raw
git clone /home/mih/dicom_demo/functional raw
bash scripts/events2ev3.sh sub-02 raw/events.tsv
dcm2niix -b y -o sub-02 raw/dicoms
sed -e "s,##BASEPATH##,$(pwd),g" scripts/ffa_design.fsf > sub-02/1stlvl_design.fsf
feat sub-02/1stlvl_design.fsf
