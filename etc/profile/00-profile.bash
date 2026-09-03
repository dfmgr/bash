#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202609031422-git
# @@Author           :  Jason Hempstead
# @@Contact          :  git-admin@casjaysdev.pro
# @@License          :  WTFPL
# @@ReadME           :  README.md
# @@Copyright        :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @@Created          :  Thursday, Mar 25, 2021 18:00 EDT
# @@File             :  00-profile.bash
# @@Description      :  sets up user/environment defaults for interactive bash sessions
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
# remove .sudo if exists
if [[ -f "$HOME/.sudo" ]]; then rm -Rf "$HOME/.sudo"; fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -x /usr/bin/id ]; then
  if [ -z "$EUID" ]; then
    EUID=$(id -u)
    UID=$(id -ru)
  fi
  USER="$(id -un)"
  LOGNAME=$USER
  MAILDIR="$HOME/.local/share/mail/local/"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ $UID -gt 199 ] && [ "$(id -gn)" = "$(id -un)" ]; then
  umask 002
else
  umask 022
fi
export USER MAILDIR LOGNAME
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End
