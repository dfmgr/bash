#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2023 Jason Hempstead, Casjays Developments
# @@Created          :  Sunday, Apr 23, 2023 21:53 EDT
# @@File             :  find.bash
# @@Description      :  Custom find function to exclude .git directories
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
find_file() { $(\builtin type -P find) -L "$@" -type "${FIND_DEFAULT_TYPE:-f}" -not -path '*/\.git/*' -not -path '*/\.svn/*' -not -path '*/\.hg/*' 2>/dev/null || return 1; }
