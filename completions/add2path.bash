#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @@Created          :  Saturday, Jul 09, 2022 20:37 EDT
# @@File             :  add2path.bash
# @@Description      :  Bash completion definitions for the add2path command
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
__add2path_completion() {
  local cur prev opts paths
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  opts="--init --help --remove --add --list"
  paths="$(echo "$PATH" | tr ':' '\n' | sort -u | grep -v '^$' | grep '^')"
  if [[ ${prev} == '--help' ]]; then
    COMPREPLY=()
    return 0
  elif [[ ${prev} == 'remove' ]] || [[ ${prev} = '--remove' ]] || [[ ${prev} = 'delete' ]] || [[ ${prev} = '--delete' ]]; then
    mapfile -t COMPREPLY < <(compgen -W "${paths}" -- "${cur}")
    return
  elif [[ ${cur} == -* ]]; then
    mapfile -t COMPREPLY < <(compgen -W "${opts}" -- "${cur}")
    return 0
  else
    declare -F _filedir >/dev/null && _filedir -d
  fi
}
complete -F __add2path_completion add2path
