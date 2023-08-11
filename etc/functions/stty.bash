#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202103251632-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : stty.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, CasjaysDev
# @Created       : Thursday, Mar 25, 2021 17:56 EDT
# @File          : stty.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
_set_stty() {
  tty -s && stty stop undef
  tty -s && stty start undef
  [[ "$OSTYPE" = darwin* ]] && tty -s && stty discard undef
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
