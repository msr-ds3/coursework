#!/bin/bash
#
# DISCLAIMER: if you're new to the command line, please do not use/run
# these commands in directories with important content, as you may
# overwrite existing files, etc. a good "scratch space" for exploring
# is the /tmp directory or similar (type "cd /tmp").
#
# file: intro.sh
#
# description: summary of basic command line / shell usage
# as discussed in class.
#
# usage: intended to be read as examples. most commands will fail,
# unless you have files name "file", "file1", "files", etc. and a
# program named "program" in your present directory. (unlikely :)) in
# principle, though, one can run this as a shell script by running
# "bash commandline_intro.sh" (or ./commandline_intro.sh with the
# script set as executable via chmod +x commandline_intro.sh.)
#
# requires:
#
# author: jmh
#

# getting help
man command

# directory listings and navigation
ls
ls -l    # detailed file description
ls -alh  # detailed, showing all (include "dot" files starting w/ "."), human-readable sizes
cd
cd dir
cd ..    # go one directory "up" in hierarchy
cd       # with no argument, change to home directory

# displaying and combining files
cat file        # concatenate file to screen
more file       # more friendly concatenation to screen, pagination
less file       # less is better than more
cat file1 file2 # concatenate two files to screen
echo string     # print string to screen

# redirection of standard input/output and pipes
program < inputfile      # redirect contents of file inputfile to program
program > outputfile     # redirect output of program to file outputfile
program1 | program2      # redirect output of program1 to input of program2
# some notes on the above:
#   - visual trick: think of redirection operators as "funnels"
#   - when using '>' or '<', you should always have a program on left
#   and file on the right
#   - when using '|', both left and right should have a program
#   - an example of confusing the above:
#       ls -l > more will write directory contents (from ls -l) to the
#       file named "more"
#       (you probably want ls -l | more, which will paginate ls -l)
#   - the following are equivalent:
#       cat inputfile | program
#       program < inputfile
#
# more on redirection at:
#   http://tldp.org/LDP/abs/html/io-redirection.html#IOREDIRREF
# more on pipes at:
#   http://tldp.org/LDP/abs/html/special-chars.html#PIPEREF

# special characters: *, ?, $
# quoting/escaping: ', "
ls -l file*    # directory listing for files starting with "file"
ls -l "file*"  # directory listing for file named file* (star in the filename = bad idea)
ls -l file?    # directory listing for files named file + 1 (arbitrary) character
echo "file"    # print the word "file" to screen
echo "file*"   # print the string "file*" to screen
echo file*     # if file* exists in directory, prints filenames matching file* (else prints string file*)
echo $var      # print contents of variable $var (likely undefined in your shell, resulting in empty string)
echo "$var"    # same as above -- double quotes don't escape $
echo '$var'    # print string '$var' -- single quotes escape $
# more on quoting at:
#   http://tldp.org/LDP/abs/html/quoting.html#QUOTINGREF

# basic searching and line count
grep pattern file         # print lines of file that match pattern
wc file                   # print number of lines, words, and characters in file
wc -l file                # print only number of lines in file
grep pattern file | wc -l # print number of lines matchine pattern in file
# note: using grep --color=auto (or similar on your
# more on grep:
#   http://www.panix.com/~elflord/unix/grep.html
#   http://code.google.com/edu/tools101/linux/grep.html

# some additional references for shell commands and basic navigation:
#   quick reference for frequently used commands: http://www.pixelbeat.org/cmdline.html
#   example command usage: http://freeengineer.org/learnUNIXin10minutes.html
#   index + description of some bash commands: http://ss64.com/bash/index.html

# other tools, in roughly decreasing priority
# cut: extract columns from delimited files
# sort: sort rows of a file
# uniq: remove (and count) running duplicate rows
# tr: substitute one set of characters (e.g., comma) with another (e.g., tab)
# awk: scripting language, useful for streaming and column-based processing
# sed: stream editor, useful for regex search and replace

# bash variables
# ``
# for loops
# conditionals
