#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202111052337-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : WTFPL
# @ReadME        : projectdir_bin.bash --help
# @Copyright     : Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @Created       : Friday, Nov 05, 2021 23:37 EDT
# @File          : projectdir_bin.bash
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set-project-path() {
  BASH_PATH=${BASH_PATH:-$PATH}                  # only set variable if unset
  for DIR in . .. ../.. ../../.. ../../../..; do # set to required lookup depth
    DIR="$DIR/node_modules/.bin"
    if [[ -d "$DIR" ]]; then
      PATH=$(pwd "$DIR"):$BASH_PATH
      [[ $1 != quit ]] || echo "set-project-path(): \$PATH += $(pwd $DIR)"
      break
    fi
  done
}
unset-project-path() {
  PATH="${BASH_PATH:-$PATH}" # reset to $BASH_PATH if previously set
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
