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
  [ -f "$LUAVER_HOME/luaver" ] &&
    . "$LUAVER_HOME/luaver"
  [ -f "$LUAVER_HOME/completions/luaver.bash" ] &&
    . "$LUAVER_HOME/completions/luaver.bash"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
