#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  casjay
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 casjay, Casjays Developments
# @@Created          :  Tuesday, Aug 03, 2021 03:05 EDT
# @@File             :  basher.bash
# @@Description      :  basher plugin
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
# basher
export BASHER_ROOT="${BASHER_ROOT:-$HOME/.local/share/misc/plugins/basher}"
if [ -n "$BASH_VERSION" ] && [ -n "$BASHER_ROOT" ]; then
  [ -f "$BASHER_ROOT/bin/basher" ] && eval "$($BASHER_ROOT/bin/basher init - bash)"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
