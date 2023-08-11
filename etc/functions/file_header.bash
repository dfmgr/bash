#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103212035-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : WTFPL
# @ReadME        : file_header.bash
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Sunday, Mar 21, 2021 20:35 EDT
# @File          : file_header.bash
# @Description   : get header information for my scripts
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
file_header() {
  printf '# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n'
  grep ^'?*#.@.*  :' "$1" | grep '  :' | grep -Ev 'GEN_SCRIPTS_*_' | head -n${2:-12} | grep '^'
  printf '# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n'
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
