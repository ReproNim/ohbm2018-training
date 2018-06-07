---
title: "ReproIn: BIDS datasets straight from the MR scanner"
teaching: 5
exercises: 25
questions:
- "How to implement basic neuroimaging study with complete and unambiguous provenance tracking of all actions?"
objectives:
- "Conduct portable and reproducible analyses with ReproIn and DataLad from ground up."
keypoints:
- "TODO"
---

## Introduction

In this lesson we will carry out a full (basic) study where **all**
materials, including complete environments will be stored and managed
by a version control system, and [HeuDiConv] will be used as a turnkey
solution to prepare our BIDS dataset from input DICOMs, which follow
[ReproIn] convention.

![XXX](../fig/yoda-schemata-1.png)


## Prepare input dataset

The goal will be to prepare a BIDS dataset from a collection of DICOMs
in a fully reproducible way, where all steps and necessary components
(data, commands, containers, etc.) are stored and/or recorded within Git.

> ## Step: Create a new DataLad dataset called `bids`
>
> Use [datalad create] command
>
> > ## Answer
> >  ~~~
> > % datalad create bids
> > [INFO   ] Creating a new annex repo at /tmp/bids
> > create(ok): /tmp/bids (dataset)
> > ~~~
> > {: .bash}
> {: .solution}
>
{: .challenge}

## Carry out simple GLM analysis

## Wrapping up

> ## Exercise: Script the entire analysis from ground up
>
> Using your shell history, prepare a shell script which will implement
> all the actions you have done, and make it take two parameters:
> - the URL for the DataLad dataset to be used (instead of the
>   <https://github.com/datalad/example-dicom-functional.git>)
> - work directory (instead of current one)
>
> Script must exit right away if any command fails or any of the
> parameters or variables remain undefined
>
> > ## Answer
> > Something like <https://github.com/myyoda/ohbm2018-training/blob/master/fsl_glm_w_amazing_datalad.sh>
> > or use [datalad rerun]: `datalad rerun --since= --script myanalysis.sh`
> {: .solution}
>
{: .challenge}

[datalad add-sibling]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-add-sibling.html
[datalad add]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-add.html
[datalad annotate-paths]: http://docs.datalad.org/en/latest/generated/man/datalad-annotate-paths.html
[datalad clean]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-clean.html
[datalad clone]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-clone.html
[datalad copy_to]: http://docs.datalad.org/en/latest/_modules/datalad/support/annexrepo.html?highlight=%22copy_to%22
[datalad create-sibling-github]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-create-sibling-github.html
[datalad create-sibling]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-create-sibling.html
[datalad create]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-create.html
[datalad datalad]: http://docs.datalad.org/en/latest/generated/man/datalad.html
[datalad drop]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-drop.html
[datalad export]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-export.html
[datalad export_tarball]: http://docs.datalad.org/en/latest/generated/datalad.plugin.export_tarball.html
[datalad get]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-get.html
[datalad install]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-install.html
[datalad ls]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-ls.html
[datalad metadata]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-metadata.html
[datalad plugin]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-plugin.html
[datalad publish]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-publish.html
[datalad remove]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-remove.html
[datalad run]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-run.html
[datalad rerun]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-rerun.html
[datalad save]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-save.html
[datalad search]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-search.html
[datalad siblings]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-siblings.html
[datalad sshrun]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-sshrun.html
[datalad update]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-update.html

[ReproIn]: http://reproin.repronim.org
[DataLad]: http://datalad.org
[HeuDiConv]: http://github.com/nipy/heudiconv