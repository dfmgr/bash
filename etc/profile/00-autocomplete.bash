#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_VERSINFO-}" ]; then
  if [ "${BASH_VERSINFO[0]}" -gt 4 ] ||
    [ "${BASH_VERSINFO[0]}" -eq 4 -a "${BASH_VERSINFO[1]}" -ge 1 ]; then
    local d=$(ls /etc/bash_completion.d/ 2>/dev/null | wc -l)
    if [ "$d" != "0" ]; then
      for f in /etc/bash_completion.d; do
        . "$f" >/dev/null 2>&1
      done
    fi
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    fi
    if [ -f /usr/local/etc/bash_completion ]; then
      . /usr/local/etc/bash_completion
    fi
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
