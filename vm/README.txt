Build the training VM OVA

QUICK START
-----------

1) Install:

    Packer: https://www.packer.io/docs/install/index.html
    Virtualbox: https://www.virtualbox.org/wiki/Downloads

1) Download:

    https://training.repronim.org/ubuntu-xenial-desktop.ova
    (place in "ohbm2018-training/vm")

    https://training.repronim.org/Indiv_Diffs_ReadingSkill.tar
    (place in "ohbm2018-training/vm/files")

2) Run:

    packer build Packerfile.json



NOTES
-----

The Indiv_Diffs_ReadingSkill.tar file was downloaded from:

    https://openneuro.org/datasets/ds001365/versions/00001