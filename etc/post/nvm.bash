#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202108030255-git
# @Author        : casjay
# @Contact       : casjay
# @License       : LICENSE.md
# @ReadME        : nvm.bash --help
# @Copyright     : Copyright: (c) 2021 casjay, casjay
# @Created       : Tuesday, Aug 03, 2021 03:05 EDT
# @File          : nvm.bash
# @Description   : node version manager
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [[ -z "$NODE_MANAGER" ]] && [[ "$NODE_MANAGER" = "nvm" ]] && [[ -n "$NVM_DIR" ]]; then
  if ! builtin type nvm &>/dev/null; then
    . "$NVM_DIR/nvm.sh"
    . "$NVM_DIR/bash_completion"
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
