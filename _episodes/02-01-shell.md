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


## Seeking help

Majority of the commands are accompanied with information about their
purpose and command line options, which is available quickly in a shell:

### `--help` or `-help` (less common, e.g. AFNI)

Typically such `--help` just causes them to print concise description
of the entire program and list of (common) command line options it supports.

> Run some sample command(s) you know (e.g. `bash`, `cat`), with `--help`.
>
> > e.g. `bash --help`
{: .challenge}

### `man`

`man` command provides access to "manual pages" (manpages for short)
available for many (if not majority) of available to you commands.
Manpages often provide a very detailed description, and consist of many
pages of textual documentation.  It gets presented to you in a `pager`
- a basic command for viewing and navigation of the text file.  Most
common are `more` and `less`.  Common shortcuts are

- `h` - help
- `<`, `Home` - beginning of the document
- `>`, `End` - end of the document
- `SPACE`, `PgDn`, `f` - page down
- `PgUp`, `b` - page up
- `/` - search
- `q` - exit

> Navigate `man` for sample commands
>
> What is the short description of `git` command?
>
{: .challenge}

`man -k` searches through all available manpages short descriptions and
command names

> Find commands for work with "containers"
>
> > `man -k containers`
>
{: .challenge}


### manpages

`man` command provides help stored in "manpages" for many commands.

> ## Navigate man page(s) for sample commands
>
> To see which command will actually be run when you intend to run a
> `COMMAND`, use `which` command, e.g.
> ~~~
> $ which python
>  # TODO
> ~~~
> {: .bash}
> Do not mix up with `locate` command, which (if available) would
> just find a file with that word somewhere in the file name/path.
{: .challenge}


## Some important environment variables and commands

Environment variables are not a feature of `a shell` per se. Every
process on any operating system inherits some "environment variables"
from its parent process. A shell just streamlines manipulation of those
environments and also uses some of them directly to guide its own
operation. Let's overview the most commonly used and manipulated
environment variables. These variables are important because they
impact what external commands and libraries you are using.

#### PATH - determines full path to the command to be executed

> ## How can you determine which command (full path to it) that you are about to use?
>
> To see which command will actually be run when you intend to run a
> `COMMAND`, use `which` command, e.g.
> ~~~
> $ which python
>  # TODO
> ~~~
> {: .bash}
> Do not mix up with `locate` command, which (if available) would
> just find a file with that word somewhere in the file name/path.
{: .solution}

> ## How can you add a new path for shell to look for commands in?
>
> 1. So that those commands take precedence over other commands named
> the same way but available elsewhere on the `PATH`?
>
> 2. So those commands are run only if not found elsewhere on the
> on the `PATH`? (rarely needed/used case)
>
> > ## Solution
> > For a new path /a/b/c:
> > 1. Use  PATH=/a/b/c:$PATH
> > 2. Use  PATH=$PATH:/a/b/c
> {: .solution}
{: .challenge}


## Shell History


## Scripting

> ## What is a shebang?
> It is the first line in the script, and which starts with `#!`
> followed by the command to be used to interpret the script, e.g.
> if a file `blah` begins with the following:
> ~~~
> #!/bin/bash
> echo "Running this script using bash"
> ~~~
> {: .bash}
> then running `./blah` is analogous to calling `/bin/bash ./blah` .
> The string "#!" is read out loud
> as "hash-bang" and therefore is shortened to "shebang."
{: .solution}


## Hints for correct/robust scripting in shell

### Fail early

By default your shell script might proceed with execution even if some
command within it fails.  This might lead to very bad side-effects

- operating on incorrect results (e.g., if command re-generating
  results failed, but script continued)
- polluting the terminal screen (or log file) with output hiding away a
  point of failure

That is why it is generally advisable to use `set -e` in the scripts
that instructs the shell to exit with non-0 exit code right when some command fails.

> ## Note on special commands
> POSIX defines [some commands as "special"](https://www.gnu.org/software/bash/manual/html_node/Special-Builtins.html#Special-Builtins),
> for which failure in execution would cause entire script to exit (even
> without set `-e`) if they return non-0 value (`break`, `:`, `.`,
> `continue`, `eval`, `exec`, `exit`, `export`, `readonly`, `return`,
> `set`, `shift`, `trap`, `unset`).
{: .callout}

If you expect that some command might fail and it is OK, handle its
failing execution explicitly, e.g. via

~~~
% command_ok_to_fail || echo "As expected command_ok_to_fail failed"
~~~
{: .bash}

or just
~~~
% command_ok_to_fail || :
~~~
{: .bash}


### Use only defined variables

By default POSIX shell and bash treat undefined variables as variables
containing an empty string:

~~~
> echo ">$undefined<"
><
~~~
{: .bash}

which also could lead to many undesired and non-reproducible
or highly undesired side-effects:

- "using" mistyped variable names
- "using" variables which were not defined yet due to the logic
  in the script.  E.g. imagine effects of `sudo rm -rf ${PREFIX}/` if
  `PREFIX` variable was not defined for some reason.

The `set -u` option instructs the shell to fail if an undefined variable is
used.

If you intended to use some variable that might still be undefined
you could either use `${var:-DEFAULT}` to provide explicit `DEFAULT`
value or just define it conditionally on being not yet defined with:

~~~
% : ${notyetdefined:=1}
% echo ${notyetdefined}
1
~~~
{: .bash}


> ## set -eu
> Just set both "fail early" modes for extra protection to make your
> scripts more deterministic and thus reproducible.
{: .callout}
