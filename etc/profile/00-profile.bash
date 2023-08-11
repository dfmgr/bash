#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : 00-profile.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 18:00 EDT
# @File          : 00-profile.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
