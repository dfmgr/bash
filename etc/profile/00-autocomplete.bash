#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -n "${BASH_VERSION-}" ] && [ -n "${PS1-}" ] && [ -z "${BASH_COMPLETION_VERSINFO-}" ]; then
  if [ "${BASH_VERSINFO[0]}" -gt 4 ] ||
    [ "${BASH_VERSINFO[0]}" -eq 4 ] && [ "${BASH_VERSINFO[1]}" -ge 1 ]; then
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    fi
    if [ -f /usr/local/etc/bash_completion ]; then
      . /usr/local/etc/bash_completion
    fi
  fi
  if [ "$(find ~/.config/bash/functions/*.bash 2>/dev/null | wc -l)" -ne 0 ] && [ ! -f /etc/bash_completion ]; then
    for f in /etc/bash_completion.d/*; do
      . "$f"
    done
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
