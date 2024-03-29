#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202108030255-git
# @Author        : casjay
# @Contact       : casjay
# @License       : LICENSE.md
# @ReadME        : basher.bash --help
# @Copyright     : Copyright: (c) 2021 casjay, casjay
# @Created       : Tuesday, Aug 03, 2021 03:05 EDT
# @File          : basher.bash
# @Description   : basher plugin
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# basher
export BASHER_ROOT="${BASHER_ROOT:-$HOME/.local/share/misc/plugins/basher}"
if [ -n "$BASH_VERSION" ] && [ -n "$BASHER_ROOT" ]; then
  [ -f "$BASHER_ROOT/bin/basher" ] && eval "$($BASHER_ROOT/bin/basher init - bash)"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
