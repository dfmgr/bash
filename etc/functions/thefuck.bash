#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2023 Jason Hempstead, Casjays Developments
# @@Created          :  Sunday, Apr 23, 2023 19:56 EDT
# @@File             :  thefuck.bash
# @@Description      :  corrects errors in previous console commands (lazy loaded)
# @@Changelog        :  standardized header to WTFPL @@-field template
# @@TODO             :  Refactor code
# @@Other            :
# @@Resource         :  https://github.com/nvbn/thefuck
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/bash
# - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202609031422-git"
# Lazy load thefuck - only load when fuck command is actually used
# This improves shell startup time significantly (thefuck is slow to init)
if command -v thefuck >/dev/null 2>&1; then
  fuck() {
    unset -f fuck 2>/dev/null
    eval "$(thefuck --enable-experimental-instant-mode --alias fuck)"
    fuck "$@"
  }
fi
