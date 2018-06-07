---
title: "Shell: Getting around the “black box”"
teaching: 10
exercises: 10
questions:
- "Why and how does using the command line/shell efficiently increase reproducibility of neuroimaging studies?"
- "How can we assure that our scripts *do the right thing*?"
objectives:
- "Provide hints on efficient use of the collected shell history of commands"
- "Explain how to make shell scripts more robust and less dangerous"
keypoints:
- "A command line shell is a powerful tool and learning additional
 'tricks' could help to make its use much more efficient, less
 error-prone, and thus more reproducible"
- "Shell scripting is the most accessible tool to automate execution of
  arbitrary set of commands; This avoids manual retyping of the
  same commands and in turn avoids typos and erroneous analyses"
---

## What is a “shell”?

*Shell* commonly refers to the UNIX shell environment, which in its
core function provides users with a CLI (command line interface) to
manipulate "environment variables" and to execute external
commands. Because desired actions are expressed as typed commands it
becomes possible to script (program) sets of those commands to be
(re-)executed repetitively or conditionally (e.g., provides constructs
for loops, functions, conditions).  So, in contrast to GUI (graphical
user interface), such automation via scripting is a native feature of
a CLI shell.  Unlike GUI integrated environments with lots of
functionality exposed in menu items and icons, shell is truly a "black
box", which has a lot of powerful features which you need to discover
first to be able to use it efficiently.  Because manipulation of files
is one of the main tasks to accomplish in a shell, usually a shell
either comes with common commands (such as `cp`, `mv`, etc.) built-in
or is accompanied by an additional package (e.g., `coreutils` in
Debian) providing those helpful command line utilities.

> ### More thorough coverage
>
>  In this training event we assume that you know basics of Shell
>  and will not go through detailed presentation of various aspects
>  which are relevant for making your work with Shell, and research
>  activities in general more reproducible.  We refer you to our full
>  version of the training materials on Shell, which covers additional
>  topics such as differences between shells, importance of environment
>  variables, unit-testing etc.  We encourage you to go through following
>  materials at any other convenient moment later on your own:
>
>   - [ReproIn Reproducible Basics Module: Command line shell (full: 3 h)](http://www.reproducibleimaging.org/module-reproducible-basics/01-shell-basics/)
{: .callout}


