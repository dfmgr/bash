#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  casjay
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Tuesday, Aug 03, 2021 03:05 EDT
# @@File             :  fnm.bash
# @@Description      :  fast node manager
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :
# @@Other            :
# @@Resource         :  https://github.com/Schniz/fnm
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
# Load fnm if not loaded
if [ "$NODE_MANAGER" = "fnm" ] && [ -z "$FNM_MULTISHELL_PATH" ]; then
  if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env)"
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - -
