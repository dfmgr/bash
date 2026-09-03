#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Friday, Nov 05, 2021 12:02 EDT
# @@File             :  dirignore.bash
# @@Description      :  add dirignore message to .gitignore file
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
dirignore() {
  local IGNORE_FILE DATE_FMT
  if [ "$1" == "--help" ]; then
    printf_help "add dirignore message to .gitignore file"
    return
  fi
  IGNORE_FILE="${1:-$PWD}/.gitignore"
  DATE_FMT="$(date '+%h-%d-%Y at %H:%M')"
  if [ -f "$IGNORE_FILE" ]; then
    if grep -qs 'ignoredirmessage' "$IGNORE_FILE"; then
      printf_blue 'dirignore is already in .gitignore'
    else
      printf_green 'Adding dirignore to gitignore'
      printf '# Disable reminder in prompt\nignoredirmessage\n' >>"$IGNORE_FILE"
    fi
  else
    printf_green 'Adding dirignore to gitignore'
    printf '# gitignore created on %s\n' "$DATE_FMT" >"$IGNORE_FILE"
    printf '# Disable reminder in prompt\nignoredirmessage\n' >>"$IGNORE_FILE"
  fi
}
