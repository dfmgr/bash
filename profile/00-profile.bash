#!/usr/bin/env bash

# Profile Custom Script

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# remove .sudo if exists
if [[ -f "$HOME/.sudo" ]]; then
  rm -Rf "$HOME/.sudo"
fi

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

export USER MAILDIR HOSTNAME

# End
