---
title: "(Neuro)Debian/Git/GitAnnex/DataLad: Distributions and Version Control"
teaching: 10
exercises: 30
questions:
- "What are the best ways to obtain and track information about software, code, and data used or produced in the study?"
objectives:
- Rehearse the knowledge of Git on how to obtain repositories locally, inspect history, commit changes
- Go over basic/main commands of APT package manager for preparing computational environments
keypoints:
- Distribution and version control systems allow for the efficient creation of tightly
  version-controlled computation environments
- DataLad assists in creating a complete record of changes
---

## Introduction

The title for this section brings together a wide range of technologies which
are at first glance completely independent:  GNU/Linux
distributions---such as Debian--- which provide computing environments,
and version control systems---such as Git---which originate in
software development.  But both
distributions and version control systems have a feature in common: they
provide means to obtain, or in other words to `install`, and to manage content
locally. Moreover, installed content components typically carry unambiguous
specification of the installed version and often its origin --
where it came from.  It is this characteristic which makes them ideal
vehicles to be used to obtain components (code,
software, data etc.) necessary for your research instead of manually
downloading and installing them.

In this training section we will concentrate on learning only a few basic
core commands for a number of popular technologies, which will help you to discover
and obtain necessary for the research project components. Moreover, we
will present a few features of DataLad which will be used in subsequent
lectures.

This ["Distributions" Google Spreadsheet](https://docs.google.com/spreadsheets/d/1bBZYLsrSTvcGEpdNv_Qdpip-vyN3rg5f9g5fBVfT9DE/edit?usp=sharing)
provides a somewhat simplified overview and an aligned comparison of the basic concepts and
commands of [Debian]/[Conda]/[PyPI]/[Git]/[git-annex]/[DataLad] if we consider their "versioned distribution"
functionality.  Please consult that spreadsheet to complete hands-on
challenges below, before sneaking into the "full" answer.

> ### More thorough coverage
>
>  If you are interested to learn more about [VCS] and [Git] in particular,
>  and package managers/distributions, we encourage you to go through following
>  materials at any other convenient moment later on your own:
>
>   - [ReproIn Reproducible Basics Module: VCS (full: 5 h)](http://www.reproducibleimaging.org/module-reproducible-basics/02-vcs/)
>   - [ReproIn Reproducible Basics Module: Package managers and distributions (full: 3 h)](http://www.reproducibleimaging.org/module-reproducible-basics/03-packages/)
{: .callout}


## (Neuro)Debian

### Debian

Debian is the largest community-driven open source project, and one of the
oldest Linux distributions.  Its platform and package format (DEB) and package
manager (APT) became very popular, especially after Debian was chosen to be the
base for many derivatives such as Ubuntu and Mint.   At the moment Debian provides
over 40,000 binary packages virtually for any field of
endeavour including many scientific applications.  Any number of those packages could be very easily
installed via a unified interface of the APT package manager and with clear information
about versioning, licensing, etc.  Interestingly, almost all Debian packages now
are  themselves guaranteed to be reproducible
(see [Debian: Reproducible Builds](https://wiki.debian.org/ReproducibleBuilds).

Because of such variety, wide range of support hardware, acknowledged stability,
adherence to principles of open and free software, Debian is a very popular
"base OS" for either direct installation on hardware, or in the cloud or
containers (docker or singularity).

### NeuroDebian

[NeuroDebian] project was established to integrate
software used for research in psychology and
neuroimaging within the standard Debian distribution.

To facilitate access to the most recent versions
of such software on already existing releases of Debian and its most popular
[derivative](https://wiki.debian.org/Derivatives) [Ubuntu],
NeuroDebian project established its own
[APT](https://en.wikipedia.org/wiki/APT_(Debian)) repository.  So, in a vein,
such repository is similar to [Debian backports](https://backports.debian.org/)
repository, but a) it also
supports Ubuntu releases, b) typically backport builds are
uploaded to NeuroDebian as soon as they are uploaded to Debian unstable, c) contains
some packages which did not make it to Debian proper yet.

To enable NeuroDebian on your standard Debian or Ubuntu machine, you could
`apt-get install neurodebian` (and follow the interactive dialogue) or just follow
the instructions on http://neuro.debian.net .

> ## Excercise: check NeuroDebian
>
> Check if  NeuroDebian is "enabled" in your VM Ubuntu installation
> > ## Solution
> > ~~~
> > % apt policy | grep -i neurodebian
> > ...
> > ~~~
> > {: .bash}
> {: .solution}
{: .challenge}

> ### Note: "God" privileges needed
>
> Operations which modify the state of the system (so not just searching/showing) require
> **s**uper **u**ser to **do** it, so it is typical to have [sudo](https://en.wikipedia.org/wiki/Sudo) tool
> installed, and used as a prefix to the command (e.g. `sudo do-evil` to
> run `do-evil` as super user)
{: .callout}

> ## Excercise: Search and Install
>
> Goal is to search for and install application(s) to visualize neuroimaging data
> (using terminal for the purpose of the excercise, although there are good GUIs as well)
>
> > ## Question: What terms did you search for?
> > ~~~
> > % apt search medical viewer
> > Sorting... Done
> > Full Text Search... Done
> > aeskulap/xenial 0.2.2b1-15 amd64
> >   medical image viewer and DICOM network client
> >
> > edfbrowser/xenial 1.57-1 amd64
> >   viewer for biosignal storage files such as bdf and edf
> >
> > fsleyes/xenial,xenial 0.15.1-2~nd16.04+1 all
> >   FSL image viewer
> >
> > libvtkgdcm-tools/xenial 2.6.3-3ubuntu3 amd64
> >   Grassroots DICOM VTK tools and utilities
> >
> > sigviewer/xenial 0.5.1+svn556-4build1 amd64
> >   GUI viewer for biosignals such as EEG, EMG, and ECG
> > ~~~
> > {: .bash}
> > ~~~
> > % apt search nifti viewer
> > Sorting... Done
> > Full Text Search... Done
> > fslview/xenial,xenial,now 4.0.1-6~nd+1+nd16.04+1 amd64 [installed]
> >   viewer for (f)MRI and DTI data
> > ~~~
> > {: .bash}
> > ~~~
> > % apt search fmri visual
> > Sorting... Done
> > Full Text Search... Done
> > connectome-workbench/xenial,now 1.3.1-1~nd16.04+1 amd64 [installed]
> >   brain visualization, analysis and discovery tool
> >
> > connectome-workbench-dbg/xenial 1.3.1-1~nd16.04+1 amd64
> >   brain visualization, analysis and discovery tool -- debug symbols
> >
> > fsl-neurosynth-atlas/data,data 0.0.20130328-1 all
> >   neurosynth - atlas for use with FSL, all 525 terms
> >
> > fsl-neurosynth-top100-atlas/data,data 0.0.20130328-1 all
> >   neurosynth - atlas for use with FSL, top 100 terms
> > ~~~
> > {: .bash}
> > So, unfortunately generally there is no standardized language to describe
> > packages, but see [DebTags](https://debtags.debian.org/) and Debian blends
> > task pages, e.g. [Debian Med imaging packages](https://blends.debian.org/med/tasks/imaging)
> > and made from the NeuroDebian-oriented [list of Software](http://neuro.debian.net/pkgs.html).
> {: .solution}
> > ## Install your choice
> > ~~~
> > % sudo apt install XXX
> > ~~~
> > {: .bash}
> {: .solution}
{: .challenge}

> ## Excercise: Multiple available versions
>
> The goal of the exercise is to be able to install the desired version of a tool
>
> > ## How many of `connectome-workbench` you see available?
> > ~~~
> > % apt policy connectome-workbench
> > connectome-workbench:
> >   Installed: 1.1.1-1
> >   Candidate: 1.3.1-1~nd16.04+1
> >   Version table:
> >      1.3.1-1~nd16.04+1 500
> >         500 http://neuro.debian.net/debian xenial/main amd64 Packages
> >      1.1.1-1 500
> >         500 http://us.archive.ubuntu.com/ubuntu xenial/universe amd64 Packages
> >         100 /var/lib/dpkg/status
> > ~~~
> > {: .bash}
> {: .solution}
>
> > ## Install `1.1.1-1` version of the `connectome-workbench`
> > ~~~
> > % sudo apt install connectome-workbench=1.1.1-1
> > ~~~
> > {: .bash}
> {: .solution}
>
> > ## For the bored/challenged: install `1.2.0-1~nd16.04+1` version of `connectome-workbench`
> >
> > - It is not readily available from NeuroDebian since was replaced by newer
> >   version
> > - There is a semi-public http://snapshot-neuro.debian.net:5002 providing snapshots of NeuroDebian
> >   - Knock the server (run `curl -s http://neuro.debian.net/_files/knock-snapshots` in a terminal) to open access for you
> > - Find when there was `1.2.0-1~nd16.04+1` available
> > - Add a new entry within `/etc/apt/sources.list.d/neurodebian.sources.list` pointing to that snapshot of NeuroDebian APT repository
> > - Update the list of known packages
> > - Verify that now it is available
> > - Install that version
> {: .solution}
{: .challenge}


## Git

We all probably do some level of version control of our files,
documents, and even data files, but without a version control **system** ([VCS])
we do it in an ad-hoc manner:

[![A Story Told in File Names by Jorge Cham, http://www.phdcomics.com/comics/archive_print.php?comicid=1323](../fig/borrowed/phd052810s.png)](http://www.phdcomics.com)

Unlike distributions (like [Debian], [conda], etc) where we (users) have only the power of selecting
some already existing versions of software, the main purpose of VCS do not only provide
access to existing versions of content, but give you the "super-power" to establish
new versions by changing or adding new content.  They also often facilitate sharing the derived
works with a complete and annotated history of content changes.

> ## Excercise -- What is Git?
> > ## Consult `man git`
> > ~~~
> > % man git | grep -A1 '^NAME'
> > NAME
> >        git - the stupid content tracker
> > ~~~
> > {: .bash}
> {: .solution}
{: .challenge}

> ## Excercise -- tell Git about yourself!
> Since [Git] makes a record of changes, please configure git to know your name and email
> (you could as well use fake email, just better be consistent to simplify attribution)
> ~~~
> % git config --global user.name "FirstName LastName"
> % git config --global user.email "ideally@real.email"
> ~~~
> {: .bash}
> Check the content of `~/.gitconfig` which is the `--global` config for git.
>
> Without `--global` configuration changes would be stored in `.git/config` of
> a particular repository
{: .challenge}

> ## Hint: use `git COMMAND --help`
>
> to obtain documentation specific to the `COMMAND`.
> Recall navigation shortcuts from the [previous section](../02-01-shell).
> Similarly `--help` is available for `datalad COMMAND`s.
{: .challenge}

> ## Excercise -- `install` AKA `clone`
> Clone [https://github.com/repronim/ohbm-training]() locally
> > ## Solution
> > I am sorry if you had to look in here ;-)
> > ~~~
> > % git clone https://github.com/ReproNim/ohbm2018-training
> > Cloning into 'ohbm2018-training'...
> > remote: Counting objects: 194, done.
> > remote: Compressing objects: 100% (46/46), done.
> > remote: Total 194 (delta 31), reused 48 (delta 21), pack-reused 126
> > Receiving objects: 100% (194/194), 133.22 KiB | 0 bytes/s, done.
> > Resolving deltas: 100% (84/84), done.
> > Checking connectivity... done.
> > ~~~
> > {: .bash}
> {: .solution}
{: .challenge}

> ## Question: What is the "version" of the content you got?
> [git clone] brings you the most recent content available in the "default branch"
> of the repository.  So what "version" of content did we get?
> > ## Solution(s)
> > Version should be something which uniquely and unambigously describes
> > content.  In Git it would be the SHA1 checksum of the commit you got
> > ~~~
> > % git show | HEAD
> > commit 2d992fe19ccd2a1c3eb8267d9e10f6c75f190eaa
> > Merge: 3a42dd1 012c53f
> > Author: JB Poline <jbpoline@gmail.com>
> > Date:   Thu Jun 14 17:55:20 2018 +0800
> > ...
> > ~~~
> > {: .bash}
> > But SHA1 is not "ordered", i.e. from observing one SHA1 you cannot tell
> > if it comes later or earlier in development of the content.
> > [git tag](https://git-scm.com/docs/git-tag) allow to "tag" specific content
> > versions with miningful and/or comparable version strings.  Run `git tag` to
> > see available tags, and then use `git describe` to give unique but also
> > ordered version of the content
> > ~~~
> > % git describe
> > 0.0.20180614  # you probably get something else ;-)
> > ~~~
> > {: .bash}
> {: .solution}
{: .challenge}

### [Git] "philosophy" in 2 minutes

- [Git] is a "stupid content tracker"
- "content" is files committed to git + associated metadata (author
  name, dates etc)
- "content" is stored under `.git/objects`
  - [Git] is a distributed VCS, so all content committed to Git
    is copied/cloned/duplicated (within `.git/objects`) across all
    clones of the repository
- "content" is identified by SHA1 checksum
- [branches](https://git-scm.com/docs/git-branch) and [tags](https://git-scm.com/docs/git-tag)
  are just references/pointers to the specific version of the content:
  - branches progress forward
  - tags are immutable
  - `.git/HEAD` points to the content (SHA1) or a reference (branch)
    of your current "version" of the repository
  - commands such as [git push], [git fetch], [git pull], etc exchange
    references (tags, branches, etc) and the content they point to
    between clones of the repository

> ## Excercise: Time travel through the full history of changes.
>
>  - Using `apt` install `gitk`
>  - Run `gitk --all`
>    - Find "fix" commits
>    - Find commits which edited `README.md`
>  - Use [git checkout] to jump to some previous commit you find
>    in the history.
>  - Use [git status] . Question:  what is "detached HEAD"?
>  - Use `git checkout master` to come back
>
{: .challenge}

## git-annex

[git-annex] is a tool which allows to manage data files within a [git] repository,
without committing (large) content of those data files directly under git.
In a nutshell, [git-annex]

- moves actual data file(s) under `.git/annex/objects`, into a file typically
  named according to the [checksum](https://en.wikipedia.org/wiki/Checksum) of
  the file's content, and in its place creates a symlink pointing to that new
  location
- **commits the symlink** (not actual data) under git, so a file of any size
  would have the same small footprint within git
- within `git-annex` branch records information about where (on which
  machine/clone or web URL), that data file is available from

so later on, if you have access to the clones of the repository which have the
copy of the file, you could easily
[git annex get](https://git-annex.branchable.com/git-annex-get/) its content
(which will download/copy that file under `.git/annex/objects`) or
[git annex drop](https://git-annex.branchable.com/git-annex-drop/) it
(which would remove that file from `.git/annex/objects`).

As a result of git not containing the actual content of those large files, but
instead containing just symlinks, and information within `git-annex` branch, it
becomes possible to

- have very lean [git] repositories, pointing to arbitrarily large files
- share such repositories on any git hosting portal (e.g. [github]).  Just do
  not forget also to push `git-annex` branch which would contain information
  about
- very quickly switch (i.e. checkout) between different states of the repository,
  because no large file would need to be created -- just symlinks

We will have exercises working with [git-annex] repositories in the next section

## DataLad

[DataLad] relies on [git] and [git-annex] to provide a platform which
encapsulates many aspects from "distributions" and VCS for management
and distribution of code, data, and computational environments.  Relying on
git-annex flexibility to reference content from the web,
[datalad.datalad.org] provides hundreds of datasets (git/git-annex
repositories) which provide access to over 12TB of neuroscience data
from different projects (such as openfmri.org, crcns.org etc).  And because
all content is unambigously versioned by [git] and [git-annex] there is
a guarantee that the content for the same version would be the same across
all clones of the dataset, regardless where content was obtained from.

DataLad embraces version control and modularity (visit poster
[2046 "YODA: YODA’s organigram on data analysis"](https://ww5.aievolution.com/hbm1801/index.cfm?do=abs.viewAbs&abs=2332)
for more information) to facilitate efficient and reproducible computation.
With DataLad you can not only gain access to the data resources and maintain
your computational scripts under version control system, you can maintain
the full record  of the computation you performed in your study.  Let's
conclude this section with minimalistic neuroimaging study while recording
the full history of changes.

> ## Step 1: Create a new dataset
> Use [datalad create] command to create a new dataset "mystudy"
> > ## Solution
> > ~~~
> > % datalad create mystudy
> > ...
> > % cd mystudy
> > ~~~
> > {: .bash}
> {: .solution}
{: .challenge}

[DataLad]: http://datalad.org
[Debian]: http://debian.org
[Ubuntu]: http://ubuntu.com
[NeuroDebian]: http://neuro.debian.net
[Git]: http://git-scm.org
[git-annex]: http://git-annex.branchable.com
[PyPI]: https://pypi.org
[NICEMAN]: http://niceman.repronim.org
[conda]: https://en.wikipedia.org/wiki/Conda_(package_manager)
[VCS]: https://en.wikipedia.org/wiki/Version_control
[datalad.datalad.org]: http://datalad.datalad.org

[git tag]: https://git-scm.com/docs/git-tag
[git push]: https://git-scm.com/docs/git-push
[git pull]: https://git-scm.com/docs/git-pull
[git fetch]: https://git-scm.com/docs/git-fetch
[git clone]: https://git-scm.com/docs/git-clone
[git status]: https://git-scm.com/docs/git-status

[datalad add-sibling]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-add-sibling.html
[datalad add]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-add.html
[datalad annotate-paths]: http://docs.datalad.org/en/latest/generated/man/datalad-annotate-paths.html
[datalad clean]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-clean.html
[datalad clone]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-clone.html
[datalad copy_to]: http://docs.datalad.org/en/latest/_modules/datalad/support/annexrepo.html?highlight=%22copy_to%22
[datalad create-sibling-github]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-create-sibling-github.html
[datalad create-sibling]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-create-sibling.html
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
[datalad save]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-save.html
[datalad search]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-search.html
[datalad siblings]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-siblings.html
[datalad sshrun]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-sshrun.html
[datalad update]: http://datalad.readthedocs.io/en/latest/generated/man/datalad-update.html

