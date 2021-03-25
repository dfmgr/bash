#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : LICENSE.md
# @ReadME        : 00-autocomplete.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:58 EDT
# @File          : 00-autocomplete.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_VERSINFO-}" ]; then
  if [ "${BASH_VERSINFO[0]}" -gt 4 ] ||
    [ "${BASH_VERSINFO[0]}" -eq 4 -a "${BASH_VERSINFO[1]}" -ge 1 ]; then
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    fi
    if [ -f /usr/local/etc/bash_completion ]; then
      . /usr/local/etc/bash_completion
    fi
  fi
  if [ "$(find /etc/bash_completion.d 2>/dev/null | wc -l)" -ne 0 ] && [ ! -f /etc/bash_completion ]; then
    for f in /etc/bash_completion.d/*; do
      . "$f"
    done
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
