#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Friday, Nov 05, 2021 22:57 EDT
# @@File             :  chmod.bash
# @@Description      :  chmod functions
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
755d() { find "${1:-.}" -type d -exec chmod -fv 755 {} +; }
755f() { find "${1:-.}" -type f -exec chmod -fv 755 {} +; }
644f() { find "${1:-.}" -type f -exec chmod -fv 644 {} +; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
