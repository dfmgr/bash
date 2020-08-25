#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_VERSINFO-}" ]; then
  if [ "${BASH_VERSINFO[0]}" -gt 4 ] ||
    [ "${BASH_VERSINFO[0]}" -eq 4 -a "${BASH_VERSINFO[1]}" -ge 1 ]; then
    if [ -f /etc/bash_completion ]; then
      source /etc/bash_completion
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
      source /usr/share/bash-completion/bash_completion
    fi
    if [ -f /usr/local/etc/bash_completion ]; then
      source /usr/local/etc/bash_completion
    fi
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
