#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202108030255-git
# @Author        : casjay
# @Contact       : casjay
# @License       : LICENSE.md
# @ReadME        : luaver.bash --help
# @Copyright     : Copyright: (c) 2021 casjay, casjay
# @Created       : Tuesday, Aug 03, 2021 03:05 EDT
# @File          : luaver.bash
# @Description   : luaver plugin
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# luaver
type -P luaver &>/dev/null || return 0
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$LUAVER_HOME/luaver" ]; then
    source "$LUAVER_HOME/luaver"
  fi
  if [ -f "$LUAVER_HOME/completions/luaver.bash" ]; then
    source "$LUAVER_HOME/completions/luaver.bash"
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
