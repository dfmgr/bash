#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202108030344-git
# @Author        : Jason
# @Contact       : jason@casjaysdev.pro
# @License       : WTFPL
# @ReadME        : zoxide --help
# @Copyright     : Copyright (c) 2021, Casjays Developments
# @Created       : Tuesday Aug 03, 2021 03:45:21 EDT
# @File          : zoxide
# @Description   :
# @TODO          :
# @Other         :
# @Resource      : https://github.com/ajeetdsouza/zoxide
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
else
  zoxide() {
    unset -f zoxide
    if [ -n "$ZOXIDE_AUTO_INSTALL" ]; then
      curl -q -LSsf "https://webinstall.dev/zoxide" | bash && eval "$(zoxide init bash)" && zoxide "$@" || return 1
    else
      printf '%s\n' "zoxide is not installed. Install it with: curl -LSsf https://webinstall.dev/zoxide | bash" >&2
      printf '%s\n' "Or set ZOXIDE_AUTO_INSTALL=1 to install it automatically on next use." >&2
      return 1
    fi
  }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
