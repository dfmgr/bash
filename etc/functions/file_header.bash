#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Sunday, Mar 21, 2021 20:35 EDT
# @@File             :  file_header.bash
# @@Description      :  get header information for my scripts
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
file_header() {
  printf '# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n'
  grep ^'?*#.@.*  :' "$1" | grep '  :' | grep -Ev 'GEN_SCRIPTS_*_' | head -n${2:-12} | grep '^'
  printf '# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n'
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
