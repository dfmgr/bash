#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202108030255-git
# @Author        : casjay
# @Contact       : casjay
# @License       : LICENSE.md
# @ReadME        : fnm.bash --help
# @Copyright     : Copyright: (c) 2021 casjay, casjay
# @Created       : Tuesday, Aug 03, 2021 03:05 EDT
# @File          : asdf.bash
# @Description   : asdf script manager
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# asdf
[ -f "$ASDF_DIR/asdf.sh" ] || return 0
if [ -n "$BASH_VERSION" ]; then
  . "$ASDF_DIR/asdf.sh"
  [ -f "$ASDF_DIR/completions/asdf.bash" ] && . "$ASDF_DIR/completions/asdf.bash"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
