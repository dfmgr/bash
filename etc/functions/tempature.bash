#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 17:56 EDT
# @@File             :  tempature.bash
# @@Description      :  Tempature conversion
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
celcius2f() {
  local math tf
  if [ -z "$1" ] || [ $# -ne 1 ]; then
    printf "Usage: celcius2f 40\n"
    return 1
  fi
  math="$1"
  tf=$(echo "scale=2;((9/5) * $math) + 32" | bc)
  printf '%s\n' "$tf"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
f2celcius() {
  local math tc
  if [ -z "$1" ] || [ $# -ne 1 ]; then
    printf "Usage: f2celcius 75\n"
    return 1
  fi
  math="$1"
  tc=$(echo "scale=2;(5/9)*($math-32)" | bc)
  printf '%s\n' "$tc"
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
