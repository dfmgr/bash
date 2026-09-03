#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 17:59 EDT
# @@File             :  00-options.bash
# @@Description      :  Bash options file
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :  https://www.gnu.org/software/bash/manual/bashref.html#The-Shopt-Builtin
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
# XSet options
if command -v xset &>/dev/null; then
  xset s off -dpms 2>/dev/null
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Automatically prepend `cd` to directory names.
shopt -s autocd 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Autocorrect typos in path names when using the `cd` command.
shopt -s cdspell 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Check the window size after each command and, if necessary, update
# the values of `LINES` and `COLUMNS`.
shopt -s checkwinsize 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Include filenames beginning with a "." in the filename expansion.
shopt -s dotglob 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Use extended pattern matching features.
shopt -s extglob 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Append to the history file rather then overwriting it.
shopt -s histappend 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Do not attempt to search the PATH for possible completions when
# completion is attempted on an empty line.
shopt -s no_empty_cmd_completion 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Match filenames in a case-insensitive fashion when performing filename expansion.
shopt -s nocaseglob 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# expand aliases
shopt -s expand_aliases 2>/dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set cursor type - blinking bar (I-beam) with cyan color
printf '\033[5 q\033]12;cyan\007'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
