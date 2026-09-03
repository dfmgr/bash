#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  jason
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2022 jason, Casjays Developments
# @@Created          :  Monday, Aug 22, 2022 00:59 EDT
# @@File             :  asdf.bash
# @@Description      :  asdf script manager
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :  Refactor code
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
# asdf
export ASDF_DIR="${ASDF_DIR:-$HOME/.local/share/misc/plugins/asdf}"
if [ -n "$BASH_VERSION" ] && [ -n "$ASDF_DIR" ]; then
  [ -f "$ASDF_DIR/asdf.sh" ] && . "$ASDF_DIR/asdf.sh"
  [ -f "$ASDF_DIR/completions/asdf.bash" ] && . "$ASDF_DIR/completions/asdf.bash"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
