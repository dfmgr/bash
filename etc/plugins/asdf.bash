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
if [ -n "$BASH_VERSION" ]; then
  if [ -d "$HOME/.local/share/misc/plugins/asdf" ]; then
    ASDF_DIR="$HOME/.local/share/misc/plugins/asdf"
    if [ -f "$ASDF_DIR/asdf.sh" ]; then
      . "$ASDF_DIR/asdf.sh"
    fi
    if [ -f "$ASDF_DIR/completions/asdf.bash" ]; then
      . "$ASDF_DIR/completions/asdf.bash"
    fi
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
