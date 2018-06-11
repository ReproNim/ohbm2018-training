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
 'tricks' can help make its use more efficient, less error-prone, and
 thus more reproducible"
- "Shell scripting is the most accessible tool to automate execution of
  an arbitrary set of commands.  This avoids manual retyping of the
  same commands and in turn avoids typos and erroneous analyses"
---

## What is a “shell”?

*Shell* commonly refers to the UNIX shell environment, which in its
core function provides users with a CLI (command line interface) to
manipulate "environment variables" and to execute external
commands. Because desired actions are expressed as typed commands, it
becomes possible to script (program) sets of commands to be
(re-)executed, using constructs such as loops, functions, and
conditional statements.  In contrast to graphical user interfaces
(GUIs), automation via scripting is a native feature of a CLI shell.
Unlike GUIs, which have lots of functionality exposed in menu items and
icons, the shell is truly a "black box", which has a lot of powerful
features that you need to discover first to be able to efficiently use
it.  Because manipulation of files is one of the main tasks to
accomplish in a shell, a shell usually either comes with common
commands (such as `cp`, `mv`, and `rm`) built-in or is accompanied by
an additional package (e.g., `coreutils` in Debian) providing those
helpful command line utilities.

> ### More thorough coverage
>
>  In this training event we assume that you know shell basics and will
>  not go through detailed presentation of various aspects that are
>  relevant for making your work in a shell---and research activities
>  in general---more reproducible.  We refer you to our full version of
>  the training materials on Unix shells, which covers additional
>  topics such as differences between shells, the importance of
>  environment variables, and unit testing.  We encourage you to go
>  through the following materials on your own at a later time:
>
>   - [ReproIn Reproducible Basics Module: Command line shell (full: 3 h)](http://www.reproducibleimaging.org/module-reproducible-basics/01-shell-basics/)
{: .callout}


## Seeking help

The majority of the commands are accompanied with easily accessible
information about their purpose and command line options.

### `--help`

Typically, commands accept a `--help` argument (or less commonly
`-help`, e.g. AFNI) and respond by printing a concise description of
the entire program and list of its (common) command line options.

> ## Task (warm up)
> Run some commands you know (e.g. `bash`, `cat`) with `--help`.
{: .challenge}

### Manual pages (AKA "manpages")

The `man` command provides access to manpages available for many (if
not the majority) of the available commands.  Manpages often provide a
very detailed description and consist of many pages of textual
documentation.  It gets presented to you in a `pager`---a basic command
for viewing and navigation of the text file.  The most common pages are
`more` and `less`.  Some useful `less` shortcuts include

- `h` - help
- `<`, `Home` - beginning of the document
- `>`, `End` - end of the document
- `SPACE`, `PgDn`, `f` - page down
- `PgUp`, `b` - page up
- `/` - search
- `q` - exit


> ## Task: Navigate `man` for `git`
>
> Question: What is the short description of the `git` command?
>
{: .challenge}

`man -k` searches through all available short descriptions and command
names.

> ## Task: Find commands for work with "containers"
>
> > ## Solution
> > ~~~
> > % man -k containers
> > ~~~
> > {: .bash}
> {: .solution}
{: .challenge}

## Beware of Vim

[![Vim and web designer](../fig/borrowed/vim-programming-joke.png)]

[Vi](http://ex-vi.sourceforge.net) and [Vim](https://www.vim.org) are
closely related that are commonly used as the default editor on Unix
and GNU/Linux systems.  While they are powerful editors, they have a
steep learning curve.  There is a number of tutorials available online
(e.g. [this randomly googled
one](https://scotch.io/tutorials/getting-started-with-vim-an-interactive-guide)).
Here we will just teach you how to exit Vi/Vim if you end up in this
unknown territory:

- `ESC` `Shift-z` `Shift-q` to quick without saving
- `ESC` `Shift-z` `Shift-z` to quick saving changes.

## Some important environment variables and commands

Environment variables are not a feature of a shell per se. Every
process on any operating system inherits some "environment variables"
from its parent process. A shell just streamlines manipulation of those
environments and also uses some of them directly to guide its own
operation. Let's overview the most commonly used and manipulated
environment variables. These variables are important because they
impact what external commands and libraries you are using.

#### PATH - determines the full path to the command to be executed

> ## Task: determine which program (full path to it) executes when you run `git`
>
> To see which command will actually be run use `which COMMAND`:
>
> ~~~
> % which git
> /usr/bin/git
> ~~~
> {: .bash}
>
> What about the `python` command?   Try `which -a` as well.
>
> Do not mix up `which` with `locate`, which (if available) would just
> find a file with that word somewhere in the file name/path.
>
{: .solution}


> ## Question: How can you add a path to where the shell looks for commands?
>
> 1. So that a command at that location takes precedence over a command
> with the same name found elsewhere on `PATH`?
>
> 2. So that a command at the location is run only if a command with
> the same name is not found elsewhere on `PATH`? (This is a rarely
> needed.)
>
> > ## Solution
> > For a new path /a/b/c:
> > 1. PATH=/a/b/c:$PATH
> > 2. PATH=$PATH:/a/b/c
> {: .solution}
{: .challenge}


## Shell History

By default, a shell records the history of commands you have run.  You
could access it using the `history` command.  When you exit the shell,
those history lines are appended to a file (`~/.bash_history` by
default in a bash shell). This not only allows you to quickly recall
commands you have run recently, but can provide you a "lab notebook" of
the actions you have performed. Thus the shell history could be
indispensable to

- determine exactly what command you have run to perform some given
  operation, and
- provide a skeleton for your script if you realize that automating the
  current operations is worthwhile.

> ## Eternal history
>
> Unfortunately by default shell history is truncated to the last 1,000
> commands, so you cannot use as your "eternal lab notebook" without
> some tuning.  Since it is a common problem, solutions exist.  Please
> review available approaches:
> - [shell-chronicle](https://github.com/con/shell-chronicle)
> - [tune up of PROMPT_COMMAND](https://debian-administration.org/article/543/Bash_eternal_history)
>   to record each command as soon as it finishes running
> - adjustment of `HISTSIZE` and `HISTCONTROL` settings,
>   e.g. [1](http://www.pointsoftware.ch/howto-bash-audit-command-logger/)
>   or [2](http://superuser.com/questions/479726/how-to-get-infinite-command-history-in-bash)
{: .callout}

Some of the main keyboard shortcuts to navigate shell history are

`Ctrl-p` | Previous line in the history
`Ctrl-n` | Next line in the history
**`Ctrl-r`** | **Bring up next match backwards in shell history** (very very useful one)

You can hit `Ctrl-r` and start typing some portion of the command you
remember running.  Hitting `Ctrl-r` again will bring up the next match
and so on. You will leave "search" mode as soon as you use some other
command line navigation command (e.g. `Ctrl-e`).

`Alt-.` | Insert last position argument of the previous command.

Hitting `Alt-.` again will bring up the last argument of the previous
command and so on.

> ## History navigation exercise
>
> Inspect your shell command history you have run so far:
> 1. use `history` and `uniq` to find you most frequently used command
> 2. experiment using `Ctrl-r` to find commands next to the most
>    popular command
{: .challenge}


## Scripting

> ## Question: What is a shebang?
>
> A shebang is a line at the beginning of a file that specifies what
> program should be used to interpret the script.  It starts with `#!`
> followed by the command.  For example, if a file `blah` begins with
> the following:
> ~~~
> #!/bin/bash
> echo "Running this script using bash"
> ~~~
> {: .bash}
> then running `./blah` is analogous to calling `/bin/bash ./blah` .
> The string "#!" is read out loud
> as "hash-bang" and therefore is shortened to "shebang."
{: .solution}


## Hints for correct and robust scripting in shell

### Fail early

By default your shell script might proceed with execution even if some
command within it fails.  This might lead to very bad side effects:

- operating on incorrect results (e.g., if a command re-generating
  results failed, but the script continued)
- polluting the terminal screen (or log file) with output that makes it
  difficult to identify the point of failure

That is why it is generally advisable to use `set -e` in scripts.  This
instructs the shell to exit with a non-zero exit code right when some
command fails.

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

which also could lead to many undesired and non-reproducible side
effects:

- "using" mistyped variable names
- "using" variables which were not defined yet due to the logic in the
  script.  Imagine the effects of `sudo rm -rf ${PREFIX}/` if `PREFIX`
  variable was not defined for some reason.

The `set -u` option instructs the shell to fail if an undefined variable is
used.

If you intend to use some variable that might be undefined, you can use
`${var:-DEFAULT}` or `${var:=DEFAULT}` to provide an explicit default
value.  Both of the `:-` and `:=` form evaluate to the default value if
the variable is unset; the difference is that the `:=` variant also
assigns the default value back to the variable.

~~~
% : ${notyetdefined:=1}
% echo ${notyetdefined}
1
~~~
{: .bash}


> ## set -eu
>
> Just set both "fail early" modes for extra protection to make your
> scripts more deterministic and thus reproducible.
{: .callout}


### Do not hardcode full paths in your scripts

Do not copy/paste full paths in your script(s).  Define a variable for
each "root directory" for a number of relevant paths, like a
`studypath=/home/me/thestudy`, `datapath=/data/commonmess`. Then use
relative paths in specifications, appending them to a "root directory"
path if needed, e.g. `"$datapath/participants.tsv"`.  This allows your
script to work across different machines and on other datasets that
conform to the same layout.  Relative paths are also preferable when
defining the relationship between two components (e.g. datasets, as you
will see in the future sections).


